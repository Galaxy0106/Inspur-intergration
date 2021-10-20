#!/bin/bash
# Create an amphora management network in CentralRegion
openstack --os-region-name CentralRegion network create lb-mgmt-net1
# Create a subnet in lb-mgmt-net1
openstack --os-region-name CentralRegion subnet create --subnet-range 192.168.10.0/24 --network lb-mgmt-net1 lb-mgmt-subnet1

id_and_mac=$(openstack --os-region-name CentralRegion port create --security-group lb-health-mgr-sec-grp --device-owner Octavia:health-mgr --network lb-mgmt-net1 octavia-health-manager-region-one-listen-port | awk '/ id | mac_address / {print $4}')
id_and_mac=($id_and_mac)
MGMT_PORT_ID=${id_and_mac[0]}
MGMT_PORT_MAC=${id_and_mac[1]}
MGMT_PORT_IP=$(openstack --os-region-name RegionOne port show -f value -c fixed_ips $MGMT_PORT_ID | awk '{FS=",| "; gsub(",",""); gsub("'\''",""); for(i = 1; i <= NF; ++i) {if ($i ~ /^ip_address/) {n=index($i, "="); if (substr($i, n+1) ~ "\\.") print substr($i, n+1)}}}')
openstack --os-region-name RegionOne port set --host $(hostname)  $MGMT_PORT_ID

