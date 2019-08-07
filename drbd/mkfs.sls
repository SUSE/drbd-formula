{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.promote

{% for res in drbd.resource %}
{% if drbd.salt.promotion == host %}
{% if res.file_system == 'xfs' %}
drbd_install_xfs:
  pkg.installed:
    - pkgs:
      - xfsprogs
{% endif %}

drbd_format_{{ res.name }}:
  blockdev.formatted:
    - name: {{ res.device|default("ext4") }}
    - fs_type: {{ res.file_system }}
    - force: True
{% endif %}
{% endfor %}
