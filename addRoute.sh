#!/bin/bash

GW_ADDR=$1

if [ '$GW_ADDR' = '' ] ; then
	exit
fi

sudo route add -net 141.146.118.0 netmask 255.255.255.0 gw $GW_ADDR
sudo route add -net 74.125.155.0 netmask 255.255.255.0 gw $GW_ADDR
sudo route add -net 74.14.213.0 netmask 255.255.255.0 gw $GW_ADDR
