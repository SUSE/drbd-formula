{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
{% if drbd.need_format is defined and drbd.need_format is sameas true %}
format-{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device|default("ext4") }}
    - fs_type: {{ res.file_system }}
    - force: True
{% endif %}
{% endfor %}
