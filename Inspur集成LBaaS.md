## 修改RegionOne和RegionTwo的/etc/kolla/neutron.conf
```shell
# 以RegionOne为例

# Modify
[default]
core_plugin = tricircle.network.local_plugin.TricirclePlugin 
service_plugins = tricircle.network.local_l3_plugin.TricircleL3Plugin
# Add
[client]
auth_url = http://10.48.51.123:35357
identity_url = http://10.48.51.123:5000 
auto_refresh_endpoint = True
top_region_name = CentralRegion 
admin_username = admin
admin_password = Inspur1! #控制台的密码
admin_tenant = admin 
admin_user_domain_name = Default 
admin_tenant_domain_name = Default 
# Add
[tricircle]
real_core_plugin = neutron.plugins.ml2.plugin.Ml2Plugin
central_neutron_url = http://10.48.51.123:20001

# 重启neutron-server使之生效
docker restart neutron-server
```

## 修改/opt/tricircle/etc/api.conf
```shell
[DEFAULT]
tricircle_db_connection = mysql+pymysql://root:LzSeZTC2m7oilUGNavmNXDbLVj8sWUgEWJMoxgxq@10.48.51.123/tricircle?charset=utf8
transport_url = rabbit://openstack:N0dAgoEtUfgHxgAj97zbnBRjDHFtFNoeUWuiGmBY@10.48.51.123:5672

[keystone_authtoken]
auth_type = password
auth_url = http://10.48.51.123:35357
www_authenticate_uri = http://10.48.51.123:5000
username = tricircle
password = I6_spur!
user_domain_name = Default
project_name = service
project_domain_name = Default
signing_dir = /var/cache/tricircle
memcached_servers = 10.48.51.123:11211

[client]
auth_url = http://10.48.51.123:35357
identity_url = http://10.48.51.123:5000
auto_refresh_endpoint = True
top_region_name = CentralRegion
admin_username = admin
admin_password = Inspur1!
admin_tenant = admin
admin_user_domain_name = Default
admin_tenant_domain_name = Default

# 创建Tricircle数据库的表结构
tricircle-db-manage --config-file /opt/tricircle/etc/api.conf db_sync
```

## 修改/opt/tricircle/etc/xjob.conf
```shell
[DEFAULT]
tricircle_db_connection = mysql+pymysql://root:LzSeZTC2m7oilUGNavmNXDbLVj8sWUgEWJMoxgxq@10.48.51.123/tricircle?charset=utf8
transport_url = rabbit://openstack:N0dAgoEtUfgHxgAj97zbnBRjDHFtFNoeUWuiGmBY@10.48.51.123:5672

[client]
auth_url = http://10.48.51.123:35357
identity_url = http://10.48.51.123:5000
auto_refresh_endpoint = True
top_region_name = CentralRegion
admin_username = admin
admin_password = Inspur1!
admin_tenant = admin
admin_user_domain_name = Default
admin_tenant_domain_name = Default
```

## 启动t-api和x-job进程
```shell
screen -S t-api 
tricircle-api --config-file /opt/tricircle/etc/api.conf 
screen -S t-xjob 
tricircle-xjob --config-file /opt/tricircle/etc/xjob.conf
```

## 修改/opt/neutron/etc/neutron.conf
```shell
[DEFAULT]
tricircle_db_connection = mysql+pymysql://root:LzSeZTC2m7oilUGNavmNXDbLVj8sWUgEWJMoxgxq@10.48.51.123/tricircle?charset=utf8
transport_url = rabbit://openstack:N0dAgoEtUfgHxgAj97zbnBRjDHFtFNoeUWuiGmBY@10.48.51.123:5672
core_plugin = tricircle.network.central_plugin.TricirclePlugin
service_plugins =
bind_port = 20001

[client]
auth_url = http://10.48.51.123:35357
identity_url = http://10.48.51.123:5000
auto_refresh_endpoint = True
top_region_name = CentralRegion
admin_username = admin
admin_password = Inspur1!
admin_tenant = admin
admin_user_domain_name = Default
admin_tenant_domain_name = Default

[keystone_authtoken]
auth_type = password
auth_url = http://10.48.51.123:35357
www_authenticate_uri = http://10.48.51.123:5000
username = neutron
password = #C&8xU@1w%ro!WS3
user_domain_name = Default
project_name = service
project_domain_name = Default
signing_dir = /var/cache/neutron0
memcached_servers = 10.48.51.123:11211

[database]
connection = mysql+pymysql://root:LzSeZTC2m7oilUGNavmNXDbLVj8sWUgEWJMoxgxq@10.48.51.123/neutron0?charset=utf8

[tricircle]
enable_api_gateway = False
tenant_network_types = vxlan
type_drivers = flat,vlan,vxlan
flat_networks = physnet1
network_vlan_ranges =
vni_ranges = 1:1000
bridge_network_type = vxlan
default_region_for_external_network = RegionOne

# 复制neutron表结构到neutron0
neutron-db-manage --config-file /opt/neutron/etc/neutron0.conf upgrade head
```

## 启动CentralNeutron的后台进程
```shell
screen -S neutron0 
neutron-server --config-file /opt/neutron/etc/neutron0.conf 
```