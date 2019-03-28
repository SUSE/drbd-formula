{%- from "drbd/map.jinja" import cluster with context -%}

{% set pattern_available = 1 %}
{% if grains['os_family'] == 'Suse' %}
{% set pattern_available = salt['cmd.retcode']('zypper search patterns-ha-ha_sles') %}
{% endif %}

{% if pattern_available == 0 %}
{% set repo = salt['pkg.info_available']('patterns-ha-ha_sles')['patterns-ha-ha_sles']['repository'] %}
patterns-ha-ha_sles:
  pkg.installed:
    - fromrepo: {{ repo }}

{% else %}

install_drbd_packages:
  pkg.installed:
    - pkgs:
      - drbd-kmp-default
      - drbd
      - drbd-utils
      - yast2-drbd

{% if cluster.with_ha is sameas true %}
install_cluster_packages:
  pkg.installed:
    - pkgs:
      - crmsh
      - ha-cluster-bootstrap
      - hawk2
      - pacemaker
      - corosync
{% endif %}

{% endif %}
