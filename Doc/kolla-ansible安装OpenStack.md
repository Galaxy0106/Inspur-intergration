# 简介
在容器中部署OpenStack的服务和基础组件
支持高度的用户定制化，用户甚至不需要有太多经验便能快速部署OpenStack

**OpenStack Services**
- Cinder
- Glance
- Keystone
- Neutron
- Nova
- Octavia
- Tempest

**Infrastructure components**
- Ceph
- HAproxy and Keepalived
- MariaDB
- Memcached
- OpenvSwitch
- RabbitMQ
- Redis

# 安装

## 安装依赖
**1. update the package index**
```shell
sudo apt update
```

**2. install python build dependencies**
```shell
sudo apt install python3-dev libffi-dev gcc libssl-dev
```

## 使用虚拟环境安装依赖
**1. install the virtual environment dependencies**
```shell
sudo apt install python3-venv
```
**2. Create a virtual environment and activate it**
```shell
python3 -m venv /path/to/venv
source /path/to/venv/bin/activate
```
**3. Ensure the latest version of pip is installed**
```shell
pip install -U pip
```
**4. Install Ansible**
```shell
pip install 'ansible<3.0'
```

## 安装kolla-ansible
**1. Install kolla-ansible and its dependencies using pip**
```shell
pip install kolla-ansible
```

**2. Create the /etc/kolla directory**
```shell
sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla
```

**3. Copy globals.yml and passwords.yml to /etc/kolla directory**
```shell
cp -r /path/to/venv/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
```

**4. Copy all-in-one and multinode inventory files to the current directory**
```shell
cp /path/to/venv/share/kolla-ansible/ansible/inventory/* .
```

