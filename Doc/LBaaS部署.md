## 创建安全组
```shell
## load balancer management network
$ openstack --os-region-name CentralRegion security group create lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol icmp lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol icmpv6 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp

## healthy manager
$ openstack --os-region-name CentralRegion security group create lb-health-mgr-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 lb-health-mgr-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 --ethertype IPv6 --remote-ip ::/0 lb-health-mgr-sec-grp
```

## 创建网络
```shell
$ openstack --os-region-name CentralRegion network create lb-mgmt-net1
$ openstack --os-region-name CentralRegion subnet create --subnet-range 192.168.10.0/24 --network lb-mgmt-net1 lb-mgmt-subnet1
```

##
```shell
## MGMT_PORT_MAC: fa:16:3e:12:10:b0
## MGMT_PORT_ID: 7873e7d0-46d8-4c32-9fda-7599ff4a5df6
sudo ovs-vsctl -- --may-exist add-port ${OVS_BRIDGE:-br-int} o-hm0 -- set Interface o-hm0 type=internal -- set Interface o-hm0 external-ids:iface-status=active -- set Interface o-hm0 external-ids:attached-mac=fa:16:3e:12:10:b0 -- set Interface o-hm0 external-ids:iface-id=7873e7d0-46d8-4c32-9fda-7599ff4a5df6 -- set Interface o-hm0 external-ids:skip_cleanup=true


$ sudo dhclient -v o-hm0
# Internet Systems Consortium DHCP Client 4.3.6
# Copyright 2004-2017 Internet Systems Consortium.
# All rights reserved.
# For info, please visit https://www.isc.org/software/dhcp/

# Listening on LPF/o-hm0/fa:16:3e:d1:b3:b2
# Sending on   LPF/o-hm0/fa:16:3e:d1:b3:b2
# Sending on   Socket/fallback
# DHCPDISCOVER on o-hm0 to 255.255.255.255 port 67 interval 8 (xid=0xbe4d70)
# DHCPREQUEST on o-hm0 to 255.255.255.255 port 67 (xid=0xbe4d70)
# DHCPOFFER from 192.168.10.2
# DHCPACK from 192.168.10.2 (xid=0xbe4d70)
# bound to 192.168.10.9 -- renewal in 42200 seconds.
```


```
lb-mgmt-net1-ID: e4583676-49a5-4135-904e-355e8b5d2c55
lb-mgmt-sec-grp-ID: 0cd47e53-1ef0-4dc0-bfb2-5fde95d6ef63
```


```shell
$ openstack --os-region-name CentralRegion network create LB-net1
$ openstack --os-region-name CentralRegion subnet create --subnet-range 10.0.50.0/24 --gateway none --network LB-net1 LB-subnet1


$ openstack --os-region-name RegionOne loadbalancer create --name lb1 --vip-subnet-id 43c4a74f-86ec-4fa5-9675-9ed9b4a1c098


```



## 错误
```
## Failed to build compute instance due to: Unexpected API Error


## No valid host

## Quota exceed for cores

## 连不上虚拟机
sudo iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT

## Invalid key_name provided, Failure: octavia.common.exceptions.ComputeBuildException: Failed to build compute instance due to: Invalid key_name provided

```
