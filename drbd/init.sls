{% from "drbd/map.jinja" import drbd with context %}
#{% set host = grains['host'] %}

include:
#  - .pre_validation
{% if drbd.install_packages is sameas true %}
  - .packages
{% endif %}
  - .drbd_kmod
  - .global_confs
  - .res
  - .create
{% if drbd.action is defined %}
  - .create
  - .down
  - .remove
  - .up
{% endif %}
