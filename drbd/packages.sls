{%- from "drbd/map.jinja" import drbd with context -%}

{% set pattern_available = 1 %}
{% if grains['os_family'] == 'Suse' %}
{% set pattern_available = salt['cmd.retcode']('zypper search patterns-ha-ha_sles') %}
{% endif %}

{% if pattern_available == 0 %}
{% set repo = salt['pkg.info_available']('patterns-ha-ha_sles')['patterns-ha-ha_sles']['repository'] %}
install-ha-ha_sles-pattern-for-drbd:
  pkg.installed:
    - fromrepo: {{ repo }}
    - pkgs:
      - patterns-ha-ha_sles

{% else %}

install_drbd_packages:
  pkg.installed:
    - pkgs:
      - drbd-kmp-default
      - drbd
      - drbd-utils
      - yast2-drbd

{% if drbd.with_ha is sameas true %}
install_cluster_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - crmsh
      - ha-cluster-bootstrap
      - hawk2
      - pacemaker
      - corosync

{% else %}

install_nfs_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - nfs-formula

{% endif %}
{% endif %}
