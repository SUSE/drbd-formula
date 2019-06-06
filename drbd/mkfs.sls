{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
{% if drbd.format_as is defined %}
format-{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device }}
    - fs_type: {{ drbd.format_as }}
    - force: True
{% endif %}
{% endfor %}
