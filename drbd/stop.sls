{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
stop-{{ res.name }}:
  drbd.stopped:
    - name: {{ res.name }}
{% endfor %}
