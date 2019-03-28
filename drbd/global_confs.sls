{%- from "drbd/map.jinja" import drbd with context -%}

/etc/drbd.conf:
  file.managed:
    - source: salt://drbd/templates/drbd.conf.j2
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        resource: {{ drbd.resource }}


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
    - context:
        usage_count: "{{ drbd.global.usage_count }}"
        minor_count: {{ drbd.global.minor_count }}
        dialog_refresh: {{ drbd.global.dialog_refresh }}
        quorum: "{{ drbd.common.options.quorum }}"
