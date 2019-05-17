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

### OPEN QUESTIONS/TODO list

 * with pacemaker
 * multiple resources/volumes
 * with lvm
 * with nfs

## Integration with other formulas

* [packages-formula](https://github.com/saltstack-formulas/packages-formula>)

``` yaml
     extends:
       packages:
         pkgs:
           wanted:
             - drbd-kmp-default
             - drbd
             - drbd-utils
             - yast2-drbd
```

## Known issues:
* Can't sync salt state running status between nodes.
  Need to implement DRBD's own approach.
