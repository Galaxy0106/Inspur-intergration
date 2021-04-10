#!/bin/bash
openstack --os-region-name CentralRegion network create net1
openstack --os-region-name CentralRegion subnet create --subnet-range 10.0.10.0/24 --gateway none --network net1 subnet1
openstack --os-region-name RegionOne flavor list
openstack --os-region-name RegionOne image list

image_id=$(openstack --os-region-name=RegionOne image list | awk 'NR==5 {print $2}')
net1_id=$(openstack --os-region-name=CentralRegion network show net1 -f value -c id)

nova --os-region-name=RegionOne boot --flavor 1 --image $image_id --nic net-id=$net1_id backend1
nova --os-region-name=RegionOne boot --flavor 1 --image $image_id --nic net-id=$net1_id backend2
