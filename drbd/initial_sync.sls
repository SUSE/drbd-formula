{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

{% for res in drbd.resource %}
{% if drbd.need_format is defined and drbd.need_format is sameas true%}
{% if res.file_system == 'xfs' %}
init_drbd_install_xfs:
  pkg.installed:
    - pkgs:
      - xfsprogs
    - retry:
        attempts: 3
        interval: 15
{% endif %}
{% endif %}
{% endfor %}

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

init-sleep-drbd-start:
  module.run:
    - test.sleep:
      - length: 3

{% for res in drbd.resource %}
{% if drbd.promotion == host %}
init-promote-{{ res.name }}:
  drbd.promoted:
    - name: {{ res.name }}
    - force: True
    - require:
      - init-sleep-drbd-start

{% else %}
init-sleep-{{ res.name }}-promote:
  module.run:
    - test.sleep:
      - length: 1
    - require:
      - init-sleep-drbd-start
{% endif %}
{% endfor %}

{% for res in drbd.resource %}
init-wait-for-{{ res.name }}-synced:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: {{ drbd.sync_interval }}
    - timeout: {{ drbd.sync_timeout }}
    - require:
{% if drbd.promotion == host %}
      - init-promote-{{ res.name }}
{% else %}
      - init-sleep-{{ res.name }}-promote
{% endif %}

# Sleep several seconds, in case one node stop before other nodes
# check disk status in wait-for-{{ res.name }}-synced
# sleep time should at least >= drbd.sync_interval
init-sleep-to-wait-all-synced-{{ res.name }}:
  module.run:
    - test.sleep:
      - length: {{ drbd.sync_interval + 5 }}
    - require:
      - init-wait-for-{{ res.name }}-synced

{% if drbd.need_format is defined and drbd.need_format is sameas true%}
{% if drbd.promotion == host %}
init-format-{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device }}
    - fs_type: {{ res.file_system|default("ext4") }}
    - force: True
    - require:
      - init-sleep-to-wait-all-synced-{{ res.name }}

{% else %}
# Not a must to wait format(mkfs) finished.
# Since eventually the later steps will be blocked
# on waiting the primary node finished format.
init-sleep-{{ res.name }}-format:
  module.run:
    - test.sleep:
      - length: 10
    - require:
      - init-sleep-to-wait-all-synced-{{ res.name }}
{% endif %}
{% endif %}

{% if drbd.stop_after_init_sync is defined and drbd.stop_after_init_sync is sameas true %}
{% if drbd.promotion == host %}
init-demote-{{ res.name }}:
  drbd.demoted:
    - name: {{ res.name }}
    - require:
{% if drbd.need_format is defined and drbd.need_format is sameas true%}
      - init-format-{{ res.name }}
{% else %}
      - init-sleep-to-wait-all-synced-{{ res.name }}
{% endif %}
{% endif %}

init-stop-{{ res.name }}:
  drbd.stopped:
    - name: {{ res.name }}
    - require:
{% if drbd.promotion == host %}
      - init-demote-{{ res.name }}
{% else %}
{% if drbd.need_format is defined and drbd.need_format is sameas true%}
      - init-sleep-{{ res.name }}-format
{% else %}
      - init-sleep-to-wait-all-synced-{{ res.name }}
{% endif %}
{% endif %}
{% endif %}

{% endfor %}
