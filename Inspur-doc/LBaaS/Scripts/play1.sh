#!/bin/bash
openstack --os-region-name CentralRegion network create net1
openstack --os-region-name CentralRegion subnet create --subnet-range 10.0.10.0/24 --gateway none --network net1 subnet1
openstack --os-region-name RegionOne flavor list
openstack --os-region-name RegionOne image list
regionone_image_id=$(openstack --os-region-name=RegionOne image list | awk 'NR==4 {print $2}')
net1_id=$(openstack --os-region-name=CentralRegion network show net1 -f value -c id)
nova --os-region-name=RegionOne boot --flavor m1.tiny --image $regionone_image_id --nic net-id=$net1_id backend1
nova --os-region-name=RegionOne boot --flavor m1.tiny --image $regionone_image_id --nic net-id=$net1_id backend2
nova --os-region-name=RegionOne list

backend1_ip=$(openstack --os-region-name=RegionOne server show backend1 -f value -c addresses | awk -F= '{print $2}')
backend2_ip=$(openstack --os-region-name=RegionOne server show backend2 -f value -c addresses | awk -F= '{print $2}')

net_ns="qdhcp-"$net1_id
password="cubswin:)"
sshcmd1="cirros@"$backend1_ip
sshcmd2="cirros@"$backend2_ip