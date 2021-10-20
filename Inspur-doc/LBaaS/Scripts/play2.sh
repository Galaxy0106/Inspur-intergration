openstack --os-region-name RegionOne loadbalancer create --name lb1 --vip-subnet-id $subnet1_id
openstack --os-region-name RegionOne loadbalancer list
openstack --os-region-name RegionOne loadbalancer listener create --protocol HTTP --protocol-port 80 --name listener1 lb1
openstack --os-region-name RegionOne loadbalancer pool create --lb-algorithm ROUND_ROBIN --listener listener1 --protocol HTTP --name pool1
openstack --os-region-name RegionOne loadbalancer member create --subnet $subnet1_id --address $backend1_ip  --protocol-port 80 pool1
openstack --os-region-name RegionOne loadbalancer member create --subnet $subnet1_id --address $backend2_ip  --protocol-port 80 pool1
