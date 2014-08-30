/etc/hosts.dnsmasq:
  file.managed:
    - source: salt://dnsmasq/files/hosts.dnsmasq
    - user: root
    - group: root
    - mode: 644
    - template: jinja

refresh hosts:
  cmd.wait:
    - name: 'pkill -SIGHUP dnsmasq'
    - watch:
      - file: /etc/hosts.dnsmasq
