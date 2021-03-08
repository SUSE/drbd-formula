``drbd_with_nfs`` via [habootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Load NFS module/service.\
> Configure ms DRBD resources.\
> Format and setup NFS on top of DRBD resources.\
> Each NFS group has a virtual IP.


* [Jinja template for drbd with nfs of crm resource](./with_pacemaker/drbd_with_nfs_crm.j2)
* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: habootstrap formula](./with_pacemaker/pillar.example.cluster)


``drbd_with_nfs`` via [ha-sap-terraform-deployments](https://github.com/SUSE/ha-sap-terraform-deployments.git) and [habootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Deploy DRBD NFS cluster with terraform project.\
> Support libvirt/azure/aws/gcp.\
> Load NFS module/service.\
> Configure ms DRBD resources.\
> Format and setup NFS on top of DRBD resources.\
> Support ha_cluster_exporter monitor.


* [Jinja template for drbd with nfs of crm resource](./with_ha-sap-terraform-deployments/drbd_with_nfs_cloud.j2)
* [Pillar: DRBD formula](./with_ha-sap-terraform-deployments/pillar.example.drbd_cloud)
* [Pillar: habootstrap formula](./with_ha-sap-terraform-deployments/pillar.example.cluster_cloud)
* [Exporter: ha_cluster_exporter monitor for split-brain](./with_ha-sap-terraform-deployments/notify-split-brain-haclusterexporter-suse-metric.sh)


``drbd_with_nfs`` via [nfs-formula](https://github.com/saltstack-formulas/nfs-formula)
-------------------
*Should run nfs.server on DRBD master only*

> Configure NFS exports.\
> Load NFS kernel module/servicer.


* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: NFS formula](./without_pacemakerout/pillar.example.nfs)
