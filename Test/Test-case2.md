## 测试环境
```shell
## 数据库
neutron03
tricircle3

## 配置文件
/opt/neutron/etc/neutron03.conf
/opt/tricircle/etc/api3.conf
/opt/tricircle/etc/x-job3.conf

## 服务
neutron03
t-api3
t-xjob3

# Network:
L3-RegionOne-net1 (10.0.10.0/24)
L3-RegionTwo-net2 (10.0.20.0/24)

# VM
L3-RegionOne-ubuntu01 (10.0.10.8)
L3-RegionTwo-ubuntu01 (10.0.20.7)
```

## 基本操作
```shell
# 关闭会话
screen -X -S {$id} quit

# 切换服务
## 1. screen关闭L3相关的会话
## 2. screen重新启动服务，注意指定非L3的配置文件
screen -S t-api3
tricircle-api --config-file /opt/tricircle/etc/api3.conf

screen -S t-xjob3
tricircle-xjob --config-file /opt/tricircle/etc/xjob3.conf

screen -S neutron03
neutron-server --config-file /opt/neutron/etc/neutron03.conf

# iperf
iperf -s -P 8000
iperf -c $server_ip -i 1 -p 8000
```

```
标明创建资源的工具
命令行截图
网络拓扑


iperf版本
```