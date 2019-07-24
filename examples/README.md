``drbd_with_nfs`` with [htbootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Load NFS module/service.\
> Configure ms DRBD resources.\
> Format and setup NFS on top of DRBD resources.\
> Each NFS group has a virtual IP.


* [Jinja template for drbd with nfs of crm resource](./with_pacemaker/drbd_with_nfs_crm.j2)
* [Pillar: DRBD formula](./with_pacemaker/pillar.example.drbd)
* [Pillar: habootstrap formula](./with_pacemaker/pillar.example.cluster)
