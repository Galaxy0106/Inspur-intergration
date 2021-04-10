#!/bin/bash
source openrc admin admin
unset OS_REGION_NAME
openstack multiregion networking pod create --region-name CentralRegion
openstack multiregion networking pod create --region-name RegionOne --availability-zone az1
openstack multiregion networking pod create --region-name RegionTwo --availability-zone az2