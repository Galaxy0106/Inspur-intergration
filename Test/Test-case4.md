## 测试资源
```shell
load balancer: lb-test2
listener: listener-test2
pool: pool-test2

VIP: 30.0.1.2
port: 8000

# 虚拟机
## RegionOne
Web-vm01: 30.0.1.3(LB-net1)
Web-vm02: 30.0.1.22(LB-net1)

## RegionTwo
Web-vm03: 30.0.1.31(LB-net1)
Web-vm04: 30.0.5.28(LB-net2-test)
```

## 演示
```shell
# In Web-vm
python3 manage.py runserver $ip:8000
./clear.sh
# In node01: ~/Web-lbaas
./curl.sh

# 注意防火墙！！！
sudo ufw allow 8000
# 浏览器快捷键
end
# Ubuntu大小写切换
Caps + ...
```