#!/bin/sh
#


for device in `fdisk -l | grep "Disk /dev/sd" | cut -d: -f1 |awk '{print $2}'`; do
  echo "========================================="> /dev/ttyS0
  echo "start clean $device" > /dev/ttyS0
  part_num=`fdisk -l |grep ^$device |awk '{print $1}' |wc -l`
  for ((i=1; i<=$((part_num)); i++));do
  echo $i
	
fdisk $device <<EOF >/dev/null 2>&1
d
${i}
w
EOF

done
  echo "$device clean success" > /dev/ttyS0
done


