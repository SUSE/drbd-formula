``drbd_with_nfs`` via [habootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Load NFS module/service.\
> Configure ms DRBD resources with pacemaker.\
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
* [Pillar: NFS formula](./without_pacemakerout/pillar.example.nfs)


``with_ha-sap-terraform-deployment`` via [ha-sap-terraform-deployments](https://github.com/SUSE/ha-sap-terraform-deployments)
-------------------
*Should run together with the terraform deployments with customized grains*

> Load NFS module/service.\
> Configure ms DRBD resources with pacemaker.\
> Format and setup NFS on top of DRBD resources.\


* [Pillar: DRBD formula](./with_ha-sap-terraform-deployment/pillar.example.drbd)
* [Pillar: habootstrap formula](./with_ha-sap-terraform-deployment/pillar.example.cluster)
* [Handler: split brain handler of monitoring](./with_ha-sap-terraform-deployment/notify-split-brain-haclusterexporter-suse-metric.sh)
