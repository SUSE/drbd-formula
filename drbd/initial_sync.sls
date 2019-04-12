{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
stop-{{ res.name }}-if-run:
  drbd.stopped:
    - name: {{ res.name }}

create-metadata-{{ res.name }}:
  drbd.initialized:
    - name: {{ res.name }}
    - force: True
    - require:
      - stop-{{ res.name }}-if-run

start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}
    - require:
      - create-metadata-{{ res.name }}
{% endfor %}

{% for res in drbd.resource %}
{% if drbd.salt.promotion is defined and drbd.salt.promotion is sameas true %}
promote-{{ res.name }}:
  drbd.promoted:
    - name: {{ res.name }}
    - force: True
    - require:
      - start-{{ res.name }}
{% else %}
sleep-{{ res.name }}:
  cmd.run:
    - name: 'sleep 3'
    - require:
      - start-{{ res.name }}
{% endif %}
{% endfor %}

{% for res in drbd.resource %}
wait-for-{{ res.name }}-synced:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: {{ drbd.salt.sync_interval|default(5) }}
    - timeout: {{ drbd.salt.sync_timeout|default(300) }}
    - require:
{% if drbd.salt.promotion is defined and drbd.salt.promotion is sameas true %}
      - promote-{{ res.name }}
{% else %}
      - sleep-{{ res.name }}
{% endif %}

{% if drbd.stop_after_init_sync is defined and drbd.stop_after_init_sync is sameas true %}
{% if drbd.salt.promotion is defined and drbd.salt.promotion is sameas true %}
demote-{{ res.name }}:
  drbd.demoted:
    - name: {{ res.name }}
    - require:
      - wait-for-{{ res.name }}-synced
{% endif %}

# Sleep several seconds, in case one node stop before other nodes
# check disk status in wait-for-{{ res.name }}-synced
# sleep time should >= drbd.salt.sync_interval
sleep-to-wait-all-before-stop-{{ res.name }}:
  cmd.run:
    - name: 'sleep {{ drbd.salt.sync_interval|default(5) + 3 }}'
    - require:
{% if drbd.salt.promotion is defined and drbd.salt.promotion is sameas true %}
      - demote-{{ res.name }}
{% else %}
      - wait-for-{{ res.name }}-synced
{% endif %}

stop-{{ res.name }}:
  drbd.stopped:
    - name: {{ res.name }}
    - require:
      - sleep-to-wait-all-before-stop-{{ res.name }}
{% endif %}

{% endfor %}
