#! /bin/bash 

USERID=$(id -u) 

if [ "$USERID" -eq 0 ]
then 
    echo " you are in super user"
     # it will exit if the user is not su
else
    echo "you need to change it to su user name"
    exit 1
    # sudo su 
    # exit
fi

dnf install mysql -y
if [ $? -ne 0 ]
then 
    echo "installation script is failure"
    exit 1
else 
    echo "installation is success"
fi
