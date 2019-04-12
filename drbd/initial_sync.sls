{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
create-metadata-{{ res.name }}:
  drbd.initialized:
    - name: {{ res.name }}

start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}
    - require:
      - create-metadata-{{ res.name }}

{% if drbd.promotion is same as true %}
promote-{{ res.name }}:
  drbd.promoted:
    - name: {{ res.name }}
    - force: True
    - require:
      - start-{{ res.name }}

wait-for-{{ res.name }}-syncsource:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: 10
    - timeout: 500
      - require:
        - promote-{{ res.name }}
{% else %}
sleep-{{ res.name }}:
  cmd.run:
    - name: 'sleep 3'
    - require:
      - start-{{ res.name }}

wait-for-{{ res.name }}-synctarget:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: 10
    - timeout: 500
      - require:
        - sleep-{{ res.name }}
{% endif %}

{% if drbd.stop_after_sync is defined %}
stop-{{ res.name }}:
  drbd.stopped:
    - name: {{ res.name }}
    - require:
{% if drbd.promotion is same as true %}
      - wait-for-{{ res.name }}-syncsource
{% else %}
      - wait-for-{{ res.name }}-synctarget
{% endif%}
{% endif%}

{% endfor %}
