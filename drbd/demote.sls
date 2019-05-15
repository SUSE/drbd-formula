{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
de-start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}

demote-{{ res.name }}:
  drbd.demoted:
    - name: {{ res.name }}
    - require:
      - de-start-{{ res.name }}
{% endfor %}
