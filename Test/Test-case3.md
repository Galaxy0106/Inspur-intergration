## 测试资源
```shell
load balancer: lb-test1
listener: listener-test1
pool: pool-test1

VIP: 30.0.1.7
port: 80

# 虚拟机
## RegionOne
backend1: 30.0.1.25(LB-net1)
backend2: 30.0.1.11(LB-net1)

## RegionTwo
backend3: 30.0.1.29(LB-net1)
backend4: 30.0.5.5(LB-net2-test)
```