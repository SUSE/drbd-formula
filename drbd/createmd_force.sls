{%- from "drbd/map.jinja" import drbd with context -%}

{# Need to modify /etc/salt/minion
  https://docs.saltstack.com/en/latest/ref/states/all/salt.states.module.html
  use_superseded:
    - module.run
#}

{% for res in drbd.resource %}
createmd-force-{{ res.name }}:
  module.run:
    - drbd.createmd:
      - name: {{ res.name }}
      - force: True
{% endfor %}
