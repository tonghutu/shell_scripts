#!/bin/bash
#Denyhosts SHELL SCRIPT
#防止SSH暴力破解
cat /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"=" $1;}' >/root/bin/Denyhosts.txt
DEFINE="10"
for i in `cat /root/bin/Denyhosts.txt`
do 
        IP=`echo $i|awk -F= '{print $1}'`
        NUM=`echo $i|awk -F= '{print $2}'`
        if [ $NUM -gt $DEFINE ]
        then
                grep $IP /etc/hosts.deny >/dev/null
                if [ $? -gt 0 ];
                then
                echo "sshd:$IP" >> /etc/hosts.deny
                fi
        fi
done
