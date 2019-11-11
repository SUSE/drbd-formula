{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
init-wait-for-{{ res.name }}-synced:
  drbd.wait_for_successful_synced:
    - name: {{ res.name }}
    - interval: {{ drbd.sync_interval }}
    - timeout: {{ drbd.sync_timeout }}
{% endfor %}
