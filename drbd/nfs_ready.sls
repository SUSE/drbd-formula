{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.additional_repos
  - drbd.mkfs

install_nfs_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - nfs-formula

{% for res in drbd.resource %}
{% if drbd.salt.promotion == host %}
{{ res.mount_point }}:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

{{ res.name }}_mountpoint:
  mount.mounted:
    - name: {{ res.mount_point }}
    - device: {{ res.device }}
    - fstype: {{ res.file_system|default("ext4") }}
    - persist: False
    - mkmnt: True
{% endif %}
{% endfor %}
