{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

{% for res in drbd.resource %}
pr-start-{{ res.name }}:
  drbd.started:
    - name: {{ res.name }}

{% if drbd.promotion != host %}
pr-demote-{{ res.name }}:
  drbd.demoted:
    - name: {{ res.name }}
    - require:
      - pr-start-{{ res.name }}
{% else %}
# Sleep for a while in case original pri not demote yet.
pr-sleep-{{ res.name }}:
  cmd.run:
    - name: 'sleep 1'
    - require:
      - pr-start-{{ res.name }}

promote-{{ res.name }}:
  drbd.promoted:
    - name: {{ res.name }}
    - force: False
    - require:
      - pr-sleep-{{ res.name }}
{% endif %}
{% endfor %}
