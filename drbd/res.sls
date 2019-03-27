drbd-res:
  file.managed:
    - name: salt://drbd/templates/{{ drbd.res.name }}.jinja
    - source: salt://drbd/templates/res-single-v9.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      name: test
      device: /dev/drbd9
      disk: /dev/vdb
      meta-disk: internal
      protocol:  C
      ping-timeout: 10
      on-io-error: pass_on
      resync-rate: 100M
      node1-name: salt-node1
      node2-name: salt-node2
      node1-ip: 192.168.10.101
      node2-ip: 192.168.10.102
      node1-port: 7990
      node2-port: 7990
      node1-id: 1
      node2-id: 2
    - context:
      name: {{ drbd.res.name }}
      device: {{ drbd.res.device }}
      disk: {{ drbd.res.disk }}
      meta-disk: {{ drbd.res.meta-disk }}
      protocol:  {{ drbd.res.protocol }}
      ping-timeout: {{ drbd.res.ping-timeout }}
      on-io-error: {{ drbd.res.on-io-error }}
      resync-rate: {{ drbd.res.resync-rate }}
      node1-name: {{ drbd.res.node1-name }}
      node2-name: {{ drbd.res.node2-name }}
      node1-ip: {{ drbd.res.node1-ip }}
      node2-ip: {{ drbd.res.node2-ip }}
      node1-port: {{ drbd.res.node1-port }}
      node2-port: {{ drbd.res.node2-port }}
      node1-id: {{ drbd.res.node1-id }}
      node2-id: {{ drbd.res.node2-id }}

  # cmd.run: for drbdadm adjust?
  #   - name: '/tmp/mac_shortcut.sh "Postgres ({{ postgres.use_upstream_repo }})"'
  #   - runas: {{ postgres.user }}
  #   - require:
  #     - file: postgres-desktop-shortcut-add
