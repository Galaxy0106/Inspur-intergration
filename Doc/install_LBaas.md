## 原理架构
![](Octavia.jpg)
## Configuration
### 安全组配置

为load balancer management network配置security group

```shell
$ openstack --os-region-name CentralRegion security group create lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol icmp lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol icmpv6 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 22 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 80 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol tcp --dst-port 9443 --ethertype IPv6 --remote-ip ::/0 lb-mgmt-sec-grp
```

为healthy manager配置security group
```shell
$ openstack --os-region-name CentralRegion security group create lb-health-mgr-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 lb-health-mgr-sec-grp
$ openstack --os-region-name CentralRegion security group rule create --protocol udp --dst-port 5555 --ethertype IPv6 --remote-ip ::/0 lb-health-mgr-sec-grp
```

### node1 LBaaS配置
```shell
# create LB management network
$ openstack --os-region-name CentralRegion network create lb-mgmt-net1
# create subnet
$ openstack --os-region-name CentralRegion subnet create --subnet-range 192.168.10.0/24 --network lb-mgmt-net1 lb-mgmt-subnet1
# create the health manager interface
$ id_and_mac=$(openstack --os-region-name CentralRegion port create --security-group lb-health-mgr-sec-grp --device-owner Octavia:health-mgr --network lb-mgmt-net1 octavia-health-manager-region-one-listen-port | awk '/ id | mac_address / {print $4}')
$ id_and_mac=($id_and_mac)
$ MGMT_PORT_ID=${id_and_mac[0]}
$ MGMT_PORT_MAC=${id_and_mac[1]}
$ MGMT_PORT_IP=$(openstack --os-region-name RegionOne port show -f value -c fixed_ips $MGMT_PORT_ID | awk '{FS=",| "; gsub(",",""); gsub("'\''",""); for(i = 1; i <= NF; ++i) {if ($i ~ /^ip_address/) {n=index($i, "="); if (substr($i, n+1) ~ "\\.") print substr($i, n+1)}}}')
$ openstack --os-region-name RegionOne port set --host $(hostname)  $MGMT_PORT_ID
$ sudo ovs-vsctl -- --may-exist add-port ${OVS_BRIDGE:-br-int} o-hm0 -- set Interface o-hm0 type=internal -- set Interface o-hm0 external-ids:iface-status=active -- set Interface o-hm0 external-ids:attached-mac=$MGMT_PORT_MAC -- set Interface o-hm0 external-ids:iface-id=$MGMT_PORT_ID -- set Interface o-hm0 external-ids:skip_cleanup=true
$ OCTAVIA_DHCLIENT_CONF=/etc/octavia/dhcp/dhclient.conf
$ sudo ip link set dev o-hm0 address $MGMT_PORT_MAC
$ sudo dhclient -v o-hm0 -cf $OCTAVIA_DHCLIENT_CONF

$ sudo iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT
# 
# Modify /etc/octavia/octavia.conf
```
### node2 LBaaS配置
同node1

## How to play
### one network, one region
```shell
# create network
$ openstack --os-region-name CentralRegion network create net1
# create subnet
$ openstack --os-region-name CentralRegion subnet create --subnet-range 10.0.10.0/24 --gateway none --network net1 subnet1
# boot VM
$ nova --os-region-name=RegionOne boot --flavor 1 --image $image_id --nic net-id=$net1_id backend1
$ nova --os-region-name=RegionOne boot --flavor 1 --image $image_id --nic net-id=$net1_id backend2

# simulate Web Server
$ sudo ip netns exec dhcp-$net1_id ssh cirros@10.0.10.152
$ sudo ip netns exec dhcp-$net1_id ssh cirros@10.0.10.176

$ MYIP=$(ifconfig eth0| grep 'inet addr'| awk -F: '{print $2}'| awk '{print $1}')
$ while true; do echo -e "HTTP/1.0 200 OK\r\n\r\nWelcome to $MYIP" | sudo nc -l -p 80 ; done&

# create load balancer
$ openstack --os-region-name RegionOne loadbalancer create --name lb1 --vip-subnet-id $subnet1_id

# Waiting the load balancer to be ACTIVE
...

# Create a listener for the loadbalancer
$ openstack --os-region-name RegionOne loadbalancer listener create --protocol HTTP --protocol-port 80 --name listener1 lb1
# Create a pool for the listener
$ openstack --os-region-name RegionOne loadbalancer pool create --lb-algorithm ROUND_ROBIN --listener listener1 --protocol HTTP --name pool1
# Add two instances into the pool as members
$ openstack --os-region-name RegionOne loadbalancer member create --subnet $subnet1_id --address $backend1_ip  --protocol-port 80 pool1
$ openstack --os-region-name RegionOne loadbalancer member create --subnet $subnet1_id --address $backend2_ip  --protocol-port 80 pool1

# Verify load balancing. Request the VIP twice.
$ sudo ip netns exec dhcp-$net1_id curl -v $VIP
```

### one network, different region
```shell
# boot VM in net1 which belongs to RegionTwo
# Request the VIP three times

```

### different network, different region
```shell
# create network in RegionTwo
# create subnet
# boot VM
# ADD into the pool as members
# Request the VIP four times
```



### octavia.conf
```
52,53c52,53
< bind_ip = 192.168.10.6
< controller_ip_port_list = 192.168.10.6:5555
---
> bind_ip = 10.7.20.110
> controller_ip_port_list = 10.7.20.110:5555
57c57
< amp_boot_network_list = 8acc6c02-66aa-4c0a-92bb-2a7a9c184ab1
---
> amp_boot_network_list =
59c59
< amp_secgroup_list = e4282699-43fd-4cb5-a709-cfaf213640f5
---
> amp_secgroup_list =
77,80c77
< region_name = CentralRegion
< service_name = neutron
< endpoint = http://10.7.20.110:20001
< endpoint_type = public
---
> region_name = RegionOne
84,86d80
< service_name = nova
< endpoint = http://10.7.20.114:8774/v2.1/b35450fd79164af4a0df26149228ddf2
< endpoint_type = public
90,92c84
< service_name = neutron
< endpoint = http://10.7.20.114:9292
< endpoint_type = public
---
>
```