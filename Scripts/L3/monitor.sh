#!/bin/bash
file="/etc/hosts"
# get ip address
line_Master=$(cat $file | grep Master)
line_Slave=$(cat $file | grep Slave)
Master_IP=$(echo $line_Master | awk '{print $1}')
Slave_IP=$(echo $line_Slave | awk '{print $1}')

echo "Master IP: $Master_IP"
echo "Slave IP: $Slave_IP"

array1=(${Master_IP//./ })
array2=(${Slave_IP//./ })

Master_subnet="${array1[0]}.${array1[1]}.${array1[2]}.0/24"
Slave_subnet="${array2[0]}.${array2[1]}.${array2[2]}.0/24"

echo $Master_subnet
echo $Slave_subnet

# get network card name
network_card=$(ifconfig | grep ^[a-z] | awk '{print $1}' | grep -v "lo" | tail -1)
echo "Network Card: $network_card"

# exclude port
port1=8031
port2=9000
port3=7077

sudo tcpdump ip host $Master_IP and $Slave_IP -i $network_card -t | grep -v "Master.$port1" \
        | grep -v "Master.$port2" | grep -v "Master.$port3" | while read line
do
        arr=(${line/ / })
        send=${arr[1]}
        recv=${arr[3]}

        #send_hostname  
        arr1=(${send/./ })
        send_host=${arr1[0]}
        #recv_hostname
        arr2=(${recv/./ })
        recv_host=${arr2[0]}

        send_region=""
        recv_region=""

        send_ip=""
        recv_ip=""

        send_subnet=""
        recv_subnet=""

        if [ $send_host = "Master" ];
        then
                send_region="RegionOne"
                recv_region="RegionTwo"
                send_ip=$Master_IP
                recv_ip=$Slave_IP
                send_subnet=$Master_subnet
                recv_subnet=$Slave_subnet
        else
                send_region="RegionTwo"
                recv_region="RegionOne"
                send_ip=$Slave_IP
                recv_ip=$Master_IP
                send_subnet=$Slave_subnet
                recv_subnet=$Master_subnet
        fi
        # match length
        len=$(echo $line | grep -P 'len.*' -o | tr -cd "[0-9]")
        echo -e "\033[31m $send_region\033[0m-$send_host IP:$send_ip Subnet:\033[31m $send_subnet\033[0m >> \033[31m $recv_region\033[0m-$send_host IP:$recv_ip Subnet:\033[31m $recv_subnet\033[0m Length Of Packet:$len Bytes"        
done
