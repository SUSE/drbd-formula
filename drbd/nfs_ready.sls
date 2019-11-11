{%- from "drbd/map.jinja" import drbd with context -%}
{% set host = grains['host'] %}

include:
  - drbd.additional_repos
  - drbd.mkfs

{% if drbd.with_ha is sameas false %}
install_nfs_formula_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - nfs-formula
{% endif %}

{% for res in drbd.resource %}
{% if drbd.promotion == host %}
drbd_{{ res.name }}_create_{{ res.mount_point }}:
  file.directory:
    - name: {{ res.mount_point }}
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644

drbd_{{ res.name }}_mountpoint:
  mount.mounted:
    - name: {{ res.mount_point }}
    - device: {{ res.device }}
    - fstype: {{ res.file_system|default("ext4") }}
    - persist: False
    - mkmnt: True
{% endif %}
{% endfor %}
