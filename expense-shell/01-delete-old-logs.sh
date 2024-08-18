#! /bin/bash

echo "program is for deleting the old logs"
find ./my_dir/*.log -mtime +10 -type f -delete

#!/bin/bash

#find /path/to/files/* -mtime +7 -exec rm {} \;
Source_Directory=/tmp/app-logs
RED="\e[31m"
GREEN="\e[32m"
GREEN="\e[33m"
ENDCOLOR="\e[0m"

if [ -d $Source_Directory]
then
    echo "source directory rxixts"
else
    echo "source directory doesnot exists"
    exit 1
fi

Files= $(find $Source_Directory -name *.log -mtime +10)
while IFS = read -r line
do
    echo "deleting the files:$line
    rm -rf $line

done <<<$Files