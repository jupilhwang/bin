#!/usr/bin/env python

import socket
from pyroute2 import IPRoute

ip = IPRoute()
oracleDomains = ['my.oracle.com','search.oraclecorp.com', 'oim.oraclecorp.com']

def getIPForHost(host):
    try:
        ips = socket.gethostbyname(host)
    except socket.gaierror:
        ips=[]
    return ips

for domain in oracleDomains:
    print( getIPForHost(domain))

# print(ip.route('del', dst='8.8.8.8'))

# print(socket.gethostbyname('www.oracle.com'))
