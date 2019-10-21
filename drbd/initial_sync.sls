{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

{% for res in drbd.resource %}
init-stop-{{ res.name }}-if-run:
  drbd.stopped:
    - name: {{ res.name }}

init-create-metadata-{{ res.name }}:
  drbd.initialized:
    - name: {{ res.name }}
    - force: True
    - require:
      - init-stop-{{ res.name }}-if-run

init-start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}
    - require:
      - init-create-metadata-{{ res.name }}
{% endfor %}

init-extra-sleep:
  cmd.run:
    - name: 'sleep 3'

{% for res in drbd.resource %}
{% if drbd.need_format is defined and drbd.need_format is sameas true%}
{% if res.file_system == 'xfs' %}
init_drbd_install_xfs:
  pkg.installed:
    - pkgs:
      - xfsprogs
{% endif %}
{% endif %}

{% if drbd.salt.promotion == host %}
init-promote-{{ res.name }}:
  drbd.promoted:
    - name: {{ res.name }}
    - force: True
    - require:
      - init-extra-sleep

{% if drbd.need_format is defined and drbd.need_format is sameas true%}
init-format-{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device }}
    - fs_type: {{ res.file_system|default("ext4") }}
    - force: True
{% endif %}

{% else %}
init-sleep-{{ res.name }}:
  cmd.run:
    - name: 'sleep 3'
    - require:
      - init-extra-sleep
{% endif %}
{% endfor %}

{% for res in drbd.resource %}
init-wait-for-{{ res.name }}-synced:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: {{ drbd.salt.sync_interval|default(5) }}
    - timeout: {{ drbd.salt.sync_timeout|default(300) }}
    - require:
{% if drbd.salt.promotion == host %}
{% if drbd.format_as is defined %}
      - init-format-{{ res.name }}
{% else %}
      - init-promote-{{ res.name }}
{% endif %}
{% else %}
      - init-sleep-{{ res.name }}
{% endif %}

{% if drbd.stop_after_init_sync is defined and drbd.stop_after_init_sync is sameas true %}
{% if drbd.salt.promotion == host %}
init-demote-{{ res.name }}:
  drbd.demoted:
    - name: {{ res.name }}
    - require:
      - init-wait-for-{{ res.name }}-synced
{% endif %}

# Sleep several seconds, in case one node stop before other nodes
# check disk status in wait-for-{{ res.name }}-synced
# sleep time should >= drbd.salt.sync_interval
init-sleep-to-wait-all-before-stop-{{ res.name }}:
  cmd.run:
    - name: 'sleep {{ drbd.salt.sync_interval|default(5) + 3 }}'
    - require:
{% if drbd.salt.promotion == host %}
      - init-demote-{{ res.name }}
{% else %}
      - init-wait-for-{{ res.name }}-synced
{% endif %}

init-stop-{{ res.name }}:
  drbd.stopped:
    - name: {{ res.name }}
    - require:
      - init-sleep-to-wait-all-before-stop-{{ res.name }}
{% endif %}

{% endfor %}
