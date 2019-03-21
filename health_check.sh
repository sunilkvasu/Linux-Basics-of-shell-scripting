# This is shebang
#!/bin/bash

# Here we declare some variables
host_list="/tmp/hosts"
checks="check_root_fs check_mem check_cpu"

# This function will check root filesystem usage
check_root_fs()
{
usage=`df -hP /|grep -v "^Filesystem"|awk {'print $(NF-1)'}|tr -d %|cut -d. -f1`
}

# This function will check memory usage
check_mem()
{
mem_total=`free -m|grep "^Mem"|awk {'print $2'}`
mem_used=`free -m|grep "^Mem"|awk {'print $3'}`
usage=`echo "scale=4;$mem_used/$mem_total*100"|bc|cut -d. -f1`
}

# This function will check cpu usage
check_cpu()
{
usage=`grep 'cpu ' /proc/stat | awk '{sum=($2+$4)*100/($2+$4+$5)} END {print sum "%"}'|cut -d. -f1`
}

# This is the main function, which calsl other functions and make the logic
main()
{
for host in `cat /tmp/hosts`; do
  echo $host
  for check in $checks; do
    $check
    if [ $usage -ge 90 ];then
      echo "$check is NOT OK"
      else
      echo "$check is OK"
    fi
  done
done
}

# Here we call our main function
main
