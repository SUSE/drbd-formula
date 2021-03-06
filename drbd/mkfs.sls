{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.promote

{% for res in drbd.resource %}
{% if drbd.promotion == host %}
{% if res.file_system == 'xfs' %}
drbd_install_xfs:
  pkg.installed:
    - pkgs:
      - xfsprogs
    - retry:
        attempts: 3
        interval: 15
{% endif %}

drbd_format_{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device }}
    - fs_type: {{ res.file_system|default("ext4") }}
    - force: True
{% endif %}
{% endfor %}
