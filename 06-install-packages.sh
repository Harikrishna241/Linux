#! /bin/bash 

USERID=$(id -u) 

if [ "$USERID" -eq 0 ]
then 
    echo " you are in super user"
    
else
    echo "you need to change it to su user name"
    exit 1

fi

echo "install packages $@"
for i in $@;
do 
    dnf install $i -y 
done

