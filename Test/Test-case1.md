## 测试环境
```shell
# 均处于同一个二层网络下
# Network
name: L2-Spark-network (60.0.10.0/24)
ID: d0f2b4f0-6036-42bc-8948-d3a7c5c2cea2

## 1. Spark
# RegionOne
spark-slave02 (60.0.10.4)
spark-slave03 (60.0.10.21)
spark-slave04 (60.0.10.16)

# RegionTwo
spark-master (60.0.10.27)
spark-slave01 (60.0.10.6)
spark-slave05 (60.0.10.8)

## 2. JITSI
# RegionOne
JITSI-vm03 (60.0.10.17)
JITSI-vm04 (60.0.10.7)

# RegionTwo
JITSI-vm01 (60.0.10.22)
JITSI-vm02 (60.0.10.20)

```
## 演示
### Spark + Hibench
...(Todo by yunqi)

### JITSI
```shell
# 关闭视频流服务
sudo /etc/init.d/jitsi-videobridge2 stop
```