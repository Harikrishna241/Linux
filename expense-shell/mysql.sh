#! /bin/bash 

#installation of my sql 
USERID=$(id -u)


if [ "$USERID" -eq 0 ]
then 
    echo "you are in super user mode and you can run the script"
else 
    echo "please run the script in su user"
    exit 1
fi
# now i need to check whther the mysql-server install or not 
yum list installed mysql-server
if [ "$?" -eq 0]
then 
    echo "mysql-server package installed"
    
else
    echo "installing the mysql-server"
    dnf install mysql-server -y
fi

#enabling the systemctl services for mysql-server

STATUS="$(systemctl is-active mysqld.service)"
if [ "${STATUS}" = "active" ]; then
    echo "mysqld your tasks ....."
    
else 
    echo " Service not running.... so activating"  
    systemctl enable mysqld
    systemctl start mysqld 
fi

#Setting up the root password for the mysql server 

mysql_secure_installation --<ipaddress of DB server > ExpenseApp@1 -e 'show databases'
if [ "$?" -ne 0]
then 
    mysql_secure_installation --set-root-pass ExpenseApp@1
    
else
    echo "mysql root passwd is already set skipping"
fi