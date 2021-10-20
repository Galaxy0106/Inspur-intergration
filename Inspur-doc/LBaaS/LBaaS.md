## 配置
1. 按照create_secgroup.sh
- RegionOne
2. 按照configure_lbaas_node1.sh
3. 如下
```shell
docker exec -it -u root openvswitch_vswitchd /bin/bash
# In container
# 修改MGMT_PORT_MAC 和 MGMT_PORT_ID
sudo ovs-vsctl -- --may-exist add-port ${OVS_BRIDGE:-br-int} o-hm0 -- set Interface o-hm0 type=internal -- set Interface o-hm0 external-ids:iface-status=active -- set Interface o-hm0 external-ids:attached-mac=$MGMT_PORT_MAC -- set Interface o-hm0 external-ids:iface-id=$MGMT_PORT_ID -- set Interface o-hm0 external-ids:skip_cleanup=true
# In host
sudo ip link set dev o-hm0 address $MGMT_PORT_MAC
# 注意记录绑定的IP
sudo dhclient -v o-hm0
sudo iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT
```
4. 修改octavia.conf
```
[health_manager]
bind_ip = 192.168.10.6
controller_ip_port_list = 192.168.10.6:5555

[controller_worker]
amp_boot_network_list = 8acc6c02-66aa-4c0a-92bb-2a7a9c184ab1
amp_secgroup_list = e4282699-43fd-4cb5-a709-cfaf213640f5

[neutron]
region_name = CentralRegion
service_name = neutron
endpoint = http://10.7.20.110:20001
endpoint_type = public

[nova]
region_name = RegionOne
service_name = nova
endpoint = http://10.7.20.114:8774/v2.1/b35450fd79164af4a0df26149228ddf2
endpoint_type = public

[glance]
region_name = RegionOne
service_name = glance
endpoint = http://10.7.20.114:9292
endpoint_type = public
```
5. 重启octavia相关的服务，按照modify_octavia.sh
- RegionTwo
6. 按照configure_lbaas_node2.sh
7. 如下
```shell
docker exec -it -u root openvswitch_vswitchd /bin/bash
# In container
# 修改MGMT_PORT_MAC 和 MGMT_PORT_ID
sudo ovs-vsctl -- --may-exist add-port ${OVS_BRIDGE:-br-int} o-hm0 -- set Interface o-hm0 type=internal -- set Interface o-hm0 external-ids:iface-status=active -- set Interface o-hm0 external-ids:attached-mac=$MGMT_PORT_MAC -- set Interface o-hm0 external-ids:iface-id=$MGMT_PORT_ID -- set Interface o-hm0 external-ids:skip_cleanup=true
# In host
sudo ip link set dev o-hm0 address $MGMT_PORT_MAC
# 注意记录绑定的IP
sudo dhclient -v o-hm0
sudo iptables -I INPUT -i o-hm0 -p udp --dport 5555 -j ACCEPT
```
8. 修改octavia.conf
```
[health_manager]
bind_ip = 
controller_ip_port_list = 

[controller_worker]
amp_boot_network_list = 8acc6c02-66aa-4c0a-92bb-2a7a9c184ab1
amp_secgroup_list = e4282699-43fd-4cb5-a709-cfaf213640f5

[neutron]
region_name = CentralRegion
service_name = neutron
endpoint = http://10.7.20.110:20001
endpoint_type = public

[nova]
region_name = RegionTwo
service_name = nova
endpoint = http://10.7.20.114:8774/v2.1/b35450fd79164af4a0df26149228ddf2
endpoint_type = public

[glance]
region_name = RegionTwo
service_name = glance
endpoint = http://10.7.20.114:9292
endpoint_type = public
```
9. 重启octavia相关的服务，按照modify_octavia.sh
### 测试
1. 按照play1.sh
2. 如下
```shell
# backend1
ip netns exec $net_ns sshpass -p $password ssh $sshcmd1
MYIP=$(ifconfig eth0| grep 'inet addr'| awk -F: '{print $2}'| awk '{print $1}')
while true; do echo -e "HTTP/1.0 200 OK\r\n\r\nWelcome to $MYIP" | sudo nc -l -p 80 ; done&
exit

# backend2
ip netns exec $net_ns sshpass -p $password ssh $sshcmd2
MYIP=$(ifconfig eth0| grep 'inet addr'| awk -F: '{print $2}'| awk '{print $1}')
while true; do echo -e "HTTP/1.0 200 OK\r\n\r\nWelcome to $MYIP" | sudo nc -l -p 80 ; done&
exit
```
3. 按照play2.sh
4. 
