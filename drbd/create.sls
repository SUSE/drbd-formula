{%- from "drbd/map.jinja" import drbd with context -%}

{% for res in drbd.resource %}
create-metadata-{{ res.name }}:
  cmd.run:
    - name: drbdadm create-md --force {{ res.name }}
{% endfor %}
