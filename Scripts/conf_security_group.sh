#!/bin/bash
source openrc admin admin
unset OS_REGION_NAME
openstack --os-region-name CentralRegion security group create lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol icmp lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol icmpv6 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp

echo "Create security group and rules for load balancer management network successfully." 

openstack --os-region-name CentralRegion security group create lb-health-mgr-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 lb-health-mgr-sec-grp
openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 --ethertype IPv6 --remote-ip ::/0 lb-health-mgr-sec-grp

echo "Create security group and rules for healthy manager successfully."