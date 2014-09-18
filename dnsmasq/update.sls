hosts_dnsmasq_update:
  file.managed:
    - name: "/opt/dnsmasq.py"
    - source: salt://dnsmasq/files/dnsmasq.py
    - user: root
    - group: root
    - mode: 644
    - template: jinja
  cmd.run:
    - name: "python /opt/dnsmasq.py"
    - user: root
    - group: root
    - requires:
      - file: hosts_dnsmasq_update
    

refresh hosts:
  cmd.wait:
    - name: 'pkill -SIGHUP dnsmasq'
    - requires:
      - cmd: hosts_dnsmasq_update
