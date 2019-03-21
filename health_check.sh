#!/bin/bash

host_list="/tmp/hosts"
checks="check_root_fs check_mem check_cpu"

check_root_fs()
{
usage=`df -hP /|grep -v "^Filesystem"|awk {'print $(NF-1)'}|tr -d %`
}

check_mem()
{
mem_total=`free -m|grep "^Mem"|awk {'print $2'}`
mem_used=`free -m|grep "^Mem"|awk {'print $3'}`
usage=`echo "scale=4;$mem_used/$mem_total*100"|bc`
}

check_cpu()
{
usage=`grep 'cpu ' /proc/stat | awk '{sum=($2+$4)*100/($2+$4+$5)} END {print sum "%"}'`
}



for host in `cat /tmp/hosts`; do
for check in checks; do
echo "$host"
$check
if [ $usage -ge 90 ]
echo "$check is NOT OK"
else
echo "$check is OK"
done

