## 配置
### 基础配置
```shell
# 配置物理结点的域名服务器
# 添加/etc/resolv.conf配置文件
# 主机上修改，重启容器
nameserver 8.8.8.8
nameserver 114.114.114.114
```


```
10.7.20.110 与 10.7.20.114 均连接到node01
10.7.20.111-10.7.20.113 为外接计算节点
```


```shell
$ openstack user create tricircle --password I6_spur!
mysql-password: sHu6PGAxRsnsF5dTo47dOAG4HhVYrL98v67LXTGz
transport: Mj6aYVrxjnx9i9sgmTJiCTGzSigWloknjaSUEmcj
```



## 错误信息
```shell
# 问题：在生成数据库表结构时报错
# ERROR: 'int' object is not iterable
# 问题原因：sqlalchemy与oslo_db的版本不一致导致的
# 解决办法：把oslo_db/sqlalchemy/engines.py中的select(1)修改为了select([1])问题得到解决
```

```shell
# 问题：neutron-server容器启动不了，neutron_lib出错
# 问题原因：容器内的neutron-lib不应该换
# 解决办法：重新起一个新的容器
$ kolla-ansible deploy -i ~/multinode -t neutron
```


## 技巧
```
pip指定目录安装的包，卸载可以直接删除文件
```

## 集成步骤
```shell
# 更换neutron-lib
$ pip install --use-feature=2020-resolver -i https://mirrors.aliyun.com/pypi/simple/ /opt/neutron-lib/
```








## 备注

