/etc/drbd.conf:
  file.managed:
    - source: salt://drbd/templates/drbd.conf
    - user: root
    - group: root
    - mode: 644

    

/etc/drbd.d/global_common.conf:
  file.managed:
    - source: salt://drbd/templates/global_common.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      usage-count: yes
      minor-count: 5
      dialog-refresh: 1
      quorum: off
    - context:
      usage-count: {{ drbd.global.usage-count }}
      minor-count: {{ drbd.global.minor-count }}
      dialog-refresh: {{ drbd.global.dialog-refresh }}
      quorum: {{ drbd.global.quorum }}

  # cmd.run: for drbdadm adjust?
  #   - name: '/tmp/mac_shortcut.sh "Postgres ({{ postgres.use_upstream_repo }})"'
  #   - runas: {{ postgres.user }}
  #   - require:
  #     - file: postgres-desktop-shortcut-add
