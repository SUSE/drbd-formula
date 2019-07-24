{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.promote

{% for res in drbd.resource %}
{% if drbd.salt.promotion == host %}
format-{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device|default("ext4") }}
    - fs_type: {{ res.file_system }}
    - force: True
{% endif %}
{% endfor %}
