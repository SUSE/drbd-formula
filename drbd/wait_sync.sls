{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
init-wait-for-{{ res.name }}-synced:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: {{ drbd.salt.sync_interval|default(5) }}
    - timeout: {{ drbd.salt.sync_timeout|default(300) }}
{% endfor %}
