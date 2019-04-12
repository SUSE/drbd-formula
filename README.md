# Version
0.1

# DRBD bootstrap salt formula

Formulas for setup and managing a drbd cluster using drbdadm.

Mainly adapted to SUSE / openSUSE Linux distributions, but should be
usable on other distributions with minor modifications.

## GOAL

Enable the configuration and installation of drbd cluster using salt.

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
