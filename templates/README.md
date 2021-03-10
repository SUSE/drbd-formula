``NFS on top of DRBD with HA cluster`` via [habootstrap-formula](https://github.com/SUSE/habootstrap-formula.git)
-------------------
> Support libvirt/azure/aws/gcp.\
> Load NFS module/service.\
> Configure ms DRBD resources.\
> Format and setup NFS on top of DRBD resources.\
> Each NFS group has a virtual IP.


* [Jinja template for drbd with nfs of crm resource simple](./habootstrap-formula/cluster_resources_nfs.j2)
* [Jinja template for drbd with nfs of crm resource with cloud](./habootstrap-formula/cluster_resources_nfs_cloud.j2)
* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: habootstrap formula](./habootstrap-formula/pillar.example.cluster)


``NFS on top of DRBD`` via [nfs-formula](https://github.com/saltstack-formulas/nfs-formula)
-------------------
*Should run nfs.server on DRBD master only*

> Configure NFS exports.\
> Load NFS kernel module/servicer.


* [Pillar: DRBD formula](./pillar.example.drbd)
* [Pillar: NFS formula](./nfs-formula/pillar.example.nfs)


``drbd split brain script`` via [ha-cluster-exporter](https://github.com/ClusterLabs/ha_cluster_exporter.git)
-------------------
> Support ha_cluster_exporter monitor DRBD split brain status.


* [Exporter: ha_cluster_exporter monitor for split-brain](./ha_cluster_exporter/notify-split-brain-haclusterexporter-suse-metric.sh)
