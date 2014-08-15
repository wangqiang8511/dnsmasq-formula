{% set name = 'dnsmasq' %}
{% set p  = salt['pillar.get'](name, {}) %}
{% set g  = salt['grains.get'](name, {}) %}
{% set defaults = {} %}
{%- do defaults.update({
    'upstream_dns_addr': '10.17.0.2',
    'dns_addr': '10.17.0.10',
    'domain': 'razerbigdata.com',
    }) 
%}

{%- set upstream_dns_addr   = g.get('upstream_dns_addr', p.get('upstream_dns_addr', defaults.upstream_dns_addr)) %}
{%- set dns_addr   = g.get('dns_addr', p.get('dns_addr', defaults.dns_addr)) %}
{%- set domain   = g.get('domain', p.get('domain', defaults.domain)) %}

{% set dnsmasq = {} %}
{%- do dnsmasq.update({
    'upstream_dns_addr': upstream_dns_addr,
    'dns_addr': dns_addr,
    'domain': domain,
    }) 
%}
