#! /bin/bash
# ubuntu、centos、debian都已测试通过，取的是第一块网卡设备的ip地址

# host_ip=`ifconfig | grep 'inet addr' | awk -F":" NR==1'{print $2}' | awk -F" " '{print $1}'`

host_ip=`ifconfig | awk -F" " '{print $2}' | awk -F":" NR==2'{print$2}'`
echo $host_ip
