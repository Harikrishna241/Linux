#! /bin/bash 

USERID = $id 

if [ USERID -eq 0 ]
then 
    echo " you are in super user"
else
    echo "you need to change it to su user name"
    sudo su -s 
    exit
fi

