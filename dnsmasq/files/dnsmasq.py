#!/usr/bin/env python
#-*- coding: utf-8 -*-

import salt


def load_host_file():
    all_records = {}
    with open("/etc/hosts.dnsmasq", 'r') as f:
        for line in f:
            data = [d.strip() for d in line.split(" ") if d.strip()]
            if len(data) > 1:
                all_records[data[1]] = data[0]
    return all_records


def get_online_ips():
    online_ips = {}
    local = salt.client.LocalClient("/etc/salt/master.d/master.conf")
    all_ret = local.cmd("*", "mine.get", arg=("*", "network.ip_addrs"))
    for k, v in all_ret.iteritems():
        for vk, vv in v.iteritems():
            online_ips[vk] = vv[0]
    return online_ips


def update_host_file(all_records, online_ips):
    for k, v in online_ips.iteritems():
        all_records[k] = v 
    with open("/etc/hosts.dnsmasq", "w") as f:
        for k, v in all_records.iteritems():
            f.write("%s %s\n\n" % (v, k)) 


def main():
    all_records = load_host_file()
    online_ips = get_online_ips()
    update_host_file(all_records, online_ips)
    pass


if __name__ == "__main__":
    main()
    pass
