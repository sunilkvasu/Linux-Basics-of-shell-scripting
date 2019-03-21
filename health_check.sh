#!/bin/bash

host_list="/tmp/hosts"

check_root_fs()
{
root_fs_usage=`df -hP /|grep -v "^Filesystem"|awk {'print $(NF-1)'}|tr -d %`
if [ $root_fs_usage -ge 90 ]; then
root_fs_health=NOK
else
root_fs_health=OK
fi
}

check_root_fs()
{
mem_total=`free -m|grep "^Mem"|awk {'print $2'}`
mem_used=`free -m|grep "^Mem"|awk {'print $3'}`
#mem_available=`free -m|grep "^Mem"|awk {'print $NF'}`
mem_usage=`echo "scale=4;$mem_used/$mem_total*100"|bc`
}




for host in `cat /tmp/hosts`; do
echo "$host"
done

