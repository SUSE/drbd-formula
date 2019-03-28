{%- from "drbd/map.jinja" import drbd with context -%}

create-metadata:
  cmd.run:
    - name: drbdadm create-md --force {{ drbd.res.name }}
