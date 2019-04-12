{% from "drbd/map.jinja" import drbd with context %}

include:
{% if drbd.install_packages is sameas true %}
  - .packages
{% endif %}
  - .drbd_kmod
  - .global_confs
  - .res
  - .initial_sync
{% if drbd.action is defined %}
  - .create
  - .start
  - .down
{% endif %}
