{%- from "drbd/map.jinja" import drbd with context -%}

/etc/drbd.conf:
  file.managed:
    - source: salt://drbd/templates/drbd.conf.j2
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        resource: {{ drbd.resource|json }}


/etc/drbd.d/global_common.conf:
  file.managed:
    - source: salt://drbd/templates/global_common.j2
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        usage_count: "no"
        minor_count: 5
        dialog_refresh: 1
        quorum: "off"
        multi_primaries: "no"
        fencing: "resource-and-stonith"
        max_buffers: 2048
        sndbuf_size: 0
        rcvbuf_size: 0
        after_sb_0pri: "discard-zero-changes"
        after_sb_1pri: "discard-secondary"
        after_sb_2pri: "disconnect"
        fence_peer: "/usr/lib/drbd/crm-fence-peer.9.sh"
        unfence_peer: "/usr/lib/drbd/crm-unfence-peer.9.sh"
        before_resync_target: "/usr/lib/drbd/snapshot-resync-target-lvm.sh -p 15 -- -c 16k"
        after_resync_target: "/usr/lib/drbd/unsnapshot-resync-target-lvm.sh"
        split_brain: "/usr/lib/drbd/notify-split-brain.sh root"
    - context:
        usage_count: "{{ drbd.global.usage_count }}"
        minor_count: {{ drbd.global.minor_count }}
        dialog_refresh: {{ drbd.global.dialog_refresh }}
        quorum: "{{ drbd.common.options.quorum }}"
        multi_primaries: "{{ drbd.common.net.multi_primaries }}"
        max_buffers: "{{ drbd.common.net.max_buffers }}"
        sndbuf_size: "{{ drbd.common.net.sndbuf_size }}"
        rcvbuf_size: "{{ drbd.common.net.rcvbuf_size }}"
        fencing: "{{ drbd.common.net.fencing }}"
        after_sb_0pri: "{{ drbd.common.net.after_sb_0pri }}"
        after_sb_1pri: "{{ drbd.common.net.after_sb_1pri }}"
        after_sb_2pri: "{{ drbd.common.net.after_sb_2pri }}"
        fence_peer: "{{ drbd.common.handlers.fence_peer }}"
        unfence_peer: "{{ drbd.common.handlers.unfence_peer }}"
        before_resync_target: "{{ drbd.common.handlers.before_resync_target }}"
        after_resync_target: "{{ drbd.common.handlers.after_resync_target }}"
        split_brain: "{{ drbd.common.handlers.split_brain }}"
