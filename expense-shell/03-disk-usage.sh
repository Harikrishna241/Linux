#! /bin/bash 

DISK_USAGE=$(df -hT | grep xfs)
Threshold=50
Message=''


while IFS = read -r line
do
    Disk_space=$DISK_USAGE | awk " " '{print($1f)}' | cut -d "%" -f1
    Folder=$(echo $DISK_USAGE | awk " " '{print($1f)}')
    if [ $Disk_space -gt $Threshold ]
    then    
        Message+="$Folder file is more than $Threshold,Ccurrent usage: $Disk_space \n" 
 
done <<<$DISK_USAGE
echo "Message:$Message"