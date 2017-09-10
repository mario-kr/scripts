#!/bin/bash

netctl start eth_stat

route del default

echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE

dhcpd eno1

