{%- from "drbd/map.jinja" import cluster with context -%}

create-metadata:
  cmd.run:
    - name: drbdadm create-md --force {{ drbd.res.name }}
