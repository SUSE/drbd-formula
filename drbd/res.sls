{%- from "drbd/map.jinja" import drbd with context -%}

/etc/drbd.d/{{ drbd.res.name ~ ".res" }}:
  file.managed:
    - source: salt://drbd/templates/res-single-v9.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        name: "test"
        device: "/dev/drbd9"
        disk: "/dev/vdb"
        meta_disk: "internal"
        protocol:  "C"
        ping_timeout: 10
        on_io_error: "pass_on"
        resync_rate: "100M"
        node1_name: "salt-node2"
        node2_name: "salt-node3"
        node1_ip: "192.168.10.102"
        node2_ip: "192.168.10.103"
        node1_port: 7990
        node2_port: 7990
        node1_id: 1
        node2_id: 2
    - context:
        name: "{{ drbd.res.name }}"
        device: "{{ drbd.res.device }}"
        disk: "{{ drbd.res.disk }}"
        meta_disk: "{{ drbd.res.meta_disk }}"
        protocol:  "{{ drbd.res.protocol }}"
        ping_timeout: "{{ drbd.res.ping_timeout }}"
        on_io_error: "{{ drbd.res.on_io_error }}"
        resync_rate: "{{ drbd.res.resync_rate }}"
        node1_name: "{{ drbd.res.node1_name }}"
        node2_name: "{{ drbd.res.node2_name }}"
        node1_ip: "{{ drbd.res.node1_ip }}"
        node2_ip: "{{ drbd.res.node2_ip }}"
        node1_port: "{{ drbd.res.node1_port }}"
        node2_port: "{{ drbd.res.node2_port }}"
        node1_id: "{{ drbd.res.node1_id }}"
        node2_id: "{{ drbd.res.node2_id }}"
