drbd-formula
===========

[![Travis Build](https://api.travis-ci.org/nick-wang/drbd-formula.svg?branch=master)](https://travis-ci.org/nick-wang/drbd-formula)

# Version
0.2.0

# DRBD bootstrap salt formula

Formulas for setup and managing a drbd cluster using drbdadm.

Mainly adapted to SUSE / openSUSE Linux distributions, but should be
usable on other distributions with minor modifications.

## GOAL

Enable the configuration and installation of drbd cluster using salt.

# How to use

1. Copy the [salt-shaptools](https://github.com/SUSE/salt-shaptools) modules and states in our salt master.

```bash
git clone https://github.com/SUSE/salt-shaptools.git
# Create /srv/salt/_modules and /srv/salt/_states if they don't exist
sudo cp salt-shaptools/salt/modules/* /srv/salt/_modules
sudo cp salt-shaptools/salt/states/* /srv/salt/_states
```

## Install (Suse distros)

The easiest way to install the formula in SUSE distributions is using a rpm package.
For that follow the next sequence to install all the dependencies (opensuse leap 15
is used in the example):

```bash
sudo zypper addrepo https://download.opensuse.org/repositories/network:ha-clustering:Factory/openSUSE_Leap_15.0/network:ha-clustering:Factory.repo
sudo zypper ref
sudo zypper in drbd-formula
```


Available states
================

.. contents::
    :local:

``drbd``
---------------

A full set for load kernel module, write configuration files, initialize resources.

``drbd.drbd_kmod``
---------------

Load the DRBD kernel module.

``drbd.global_confs``
---------------

Configure DRBD global configuration file `/etc/drbd.d/global_common.conf` and `/etc/drbd.conf`.

``drbd.res``
---------------

Configure the DRBD resource configuration files in `/etc/drbd.d/*.res`.

``drbd.create``
---------------

Create the metadata of all resources, do nothing if existed.

``drbd.createmd_force``
---------------

Call the DRBD salt module directly to `force` create metadata of all resources.

``drbd.initial_sync``
---------------

Create the metadata of all resources and run an initialize sync.

``drbd.start``
---------------

Start all DRBD resources.

``drbd.stop``
---------------

Stop all DRBD resources.

``drbd.promote``
---------------

Premote all DRBD resources.

``drbd.demote``
---------------

Demote all DRBD resources.

``drbd.wait_sync``
---------------

Waiting all DRBD resources finish syncing.
