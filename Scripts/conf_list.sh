#!/bin/bash
source openrc admin admin
unset OS_REGION_NAME

openstack --os-region-name=RegionOne endpoint list
openstack --os-region-name=CentralRegion network list
openstack --os-region-name=CentralRegion security group list
