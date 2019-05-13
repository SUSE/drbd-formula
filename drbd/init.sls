{% from "drbd/map.jinja" import drbd with context %}

include:
{% if drbd.install_packages is sameas true %}
  - drbd.packages
{% endif %}
  - drbd.drbd_kmod
  - drbd.global_confs
  - drbd.res
{% if drbd.need_init_sync is sameas true %}
  - drbd.initial_sync
{% endif %}
{% if drbd.action is defined %}
  - drbd.create
  - drbd.start
  - drbd.stop
{% endif %}
