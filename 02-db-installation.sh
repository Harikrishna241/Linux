#! /bin/bash 

USERID = $id 

if [ USERID -eq 0 ]
then 
    echo " you are in super user"
    exit 1 # it will exit if the user is not su
else
    echo "you need to change it to su user name"
    sudo su 
    exit
fi

dnf install mysql -y

echo "is script is pending"
