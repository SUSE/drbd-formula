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
{% if drbd.initaction is defined %}
  - drbd.stop
  {# Use createmd module to force create metadata #}
  - drbd.createmd_force
  - drbd.start
  {# Help to wait both nodes start first before one try to promote #}
  - drbd.sleep
  - drbd.promote
  - drbd.wait_sync
  - drbd.demote
{% endif %}
