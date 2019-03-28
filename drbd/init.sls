{% from "drbd/map.jinja" import drbd with context %}

include:
{% if drbd.install_packages is sameas true %}
  - .packages
{% endif %}
  - .drbd_kmod
  - .global_confs
  - .res
  - .create
{% if drbd.action is defined %}
  - .down
  - .remove
  - .up
{% endif %}
