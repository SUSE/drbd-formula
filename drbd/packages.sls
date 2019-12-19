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
    - retry:
        attempts: 3
        interval: 15

{% else %}

install_drbd_packages:
  pkg.installed:
    - pkgs:
      - drbd-kmp-default
      - drbd
      - drbd-utils
      - yast2-drbd
    - retry:
        attempts: 3
        interval: 15

{% if drbd.with_ha is sameas true %}
install_cluster_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - crmsh
      - ha-cluster-bootstrap
      - hawk2
      - pacemaker
      - corosync
    - retry:
        attempts: 3
        interval: 15

{% else %}

install_nfs_packages_for_drbd:
  pkg.installed:
    - pkgs:
      - nfs-formula
    - retry:
        attempts: 3
        interval: 15

{% endif %}
{% endif %}

{% for res in drbd.resource %}
{% if res.file_system == 'xfs' %}
install_xfs_pacage_for_drbd:
  pkg.installed:
    - pkgs:
      - xfsprogs
    - retry:
        attempts: 3
        interval: 15
{% endif %}
{% endfor %}
