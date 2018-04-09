#! /bin/bash

ip_array=(10.0.18.10
    10.0.19.30
    10.0.18.100)

for ip in ${ip_array[@]}
do
    disk_vendor=`ssh -Tq $ip dmidecode |grep Vendor |awk '{print $2}'`
    if [ "$disk_vendor" == "HP" ]
        then
            `scp ~/riad_check/hpacucli-9.40-12.0.x86_64.rpm $ip:~`
            sleep 2
            ssh -Tq $ip rpm -ivh ~/hpacucli-9.40-12.0.x86_64.rpm
            sleep 2
            disk_type=$(ssh -Tq $ip /opt/compaq/hpacucli/bld/./hpacucli ctrl all show config detail |grep 'Interface Type' | awk 'NR==1{print $3}')
            echo $ip 已检测完成
            echo IP: $ip \=\=\=\>\> Interface Type: $disk_type >> ./HP_IP.txt
    elif [ "$disk_vendor" == "Dell" ]
        then
            `scp ~/riad_check/MegaCli-8.07.10-1.noarch.rpm $ip:~`
            sleep 2
            ssh -Tq $ip rpm -ivh ~/MegaCli-8.07.10-1.noarch.rpm
            sleep 2
            disk_type=$(ssh -Tq $ip /opt/MegaRAID/MegaCli/./MegaCli64 -PDList -aALL | grep 'PD Type' | awk 'NR==1{print $3}')
            echo $ip 已检测完成
            echo IP: $ip \=\=\=\>\> Interface Type: $disk_type > ./DELL_IP.txt
    fi
done