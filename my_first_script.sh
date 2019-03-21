# SHEBANG
#!/bin/bash

# This is my first shell script to read data from a csv file and display 

# Variable declaration
file="/tmp/file1"
i=1
j=10

# Runtime variable declaration
echo -n "Enter hostname: "
read hostname

# Usage of for loop
for line in `cat /tmp/file1`; do
  echo $line
done
  
# Usage of while loop
while [ $i -le j ]; do
  echo "Current value of i is $i. Will continue till it reaches $j"
  i=($(i+1))
done

