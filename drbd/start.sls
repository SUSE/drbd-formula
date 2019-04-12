{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}
{% endfor %}
