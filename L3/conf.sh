#!/bin/bash
sudo sed -i "1c $1 Master" /etc/hosts
sudo sed -i "2c $2 Slave" /etc/hosts