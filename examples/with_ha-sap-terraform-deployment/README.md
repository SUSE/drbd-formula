# Pillar and handler examples
> [ha-sap-terraform-deploymet project](https://github.com/SUSE/ha-sap-terraform-deployments) `pillar_examples/automatic/drbd` (6749f1d4b, v6.0.0)

This folder store the pillar examples to work together with [ha-sap-terraform-deploymet project](https://github.com/SUSE/ha-sap-terraform-deployments). The pillar files are able to deploy a basic functional set of clusters in all of the available cloud/libvirt providers.


# Support scope:
Together with [ha-sap-terraform-deploymet project](https://github.com/SUSE/ha-sap-terraform-deployments), will support:
- aws
- azure
- gcp
- libvirt


# How to use:
> The pillar example will be only used when terraform deployment project not provide a drbd/cluster pillar files.
- [pillar.example.drbd](./pillar.example.drbd)
```
This pillar could setup a DRBD environment.
Need to rename to the drbd.sls for drbd pillar.
```
- [pillar.example.cluster](./pillar.example.cluster)
```
This pillar together with habootstrap formula can setup a HA cluster.
Need to rename to the cluster.sls for cluster pillar.
```
- [split brain handler](./notify-split-brain-haclusterexporter-suse-metric.sh)
```
This split brain handler could show split brain situation with monitoring module.
```


# Note:
The files is currently the same file of `pillar_examples/automatic/drbd` (6749f1d4b, v6.0.0). The target is not store the default pillar file in [ha-sap-terraform-deploymet project](https://github.com/SUSE/ha-sap-terraform-deployments). The pillar files from this package will be used, as long as user doesn't provide a customized pillar file in terraform deployment.

