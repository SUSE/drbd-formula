``drbd_with_nfs`` via [htbootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Load NFS module/service.\
> Configure ms DRBD resources.\
> Format and setup NFS on top of DRBD resources.\
> Each NFS group has a virtual IP.


* [Jinja template for drbd with nfs of crm resource](./with_pacemaker/drbd_with_nfs_crm.j2)
* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: habootstrap formula](./with_pacemaker/pillar.example.cluster)


``drbd_with_nfs`` via [nfs-formula](https://github.com/saltstack-formulas/nfs-formula)
-------------------
*Should run nfs.server on DRBD master only*

> Configure NFS exports.\
> Load NFS kernel module/servicer.


* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: NFS formula](./with_pacemakerout/pillar.example.nfs)
