#! /bin/bash 

#installation of my sql 
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
Script_Name=$(echo $0 | cut -d "." -f1)
log_name=/tmp/$Script_Name-$TIMESTAMP.log

#Color coding for the shell scripting output 
R="\e[31m"
G="\e[32m"
NO="\e[0m"

if [ "$USERID" -eq 0 ]
then 
    echo "you are in super user mode and you can run the script"
else 
    echo "please run the script in su user"
    exit 1
fi
# now i need to check whther the mysql-server install or not 
validate(){
    echo "print he value $?"
    if [ $? -eq 0 ]
    then 
        echo -e "$2 $G successfully $No "
            
    else
            echo -e "$2 $R failed $NO"            
    fi

}

dnf install mysql-server -y >>$log_name
validate $? "my sql-server installation"
#enabling the systemctl services for mysql-server

systemctl enable mysqld >>$log_name
validate $? "my sql-server enabled"

systemctl start mysqld >>$log_name
validate $? "my sql-server started"

#Setting up the root password for the mysql server 

# mysql_secure_installation --<ipaddress of DB server > ExpenseApp@1 -e 'show databases'
# if [ "$?" -ne 0]
# then 
#     mysql_secure_installation --set-root-pass ExpenseApp@1
    
# else
#     echo -e "mysql root passwd is already set $R skipping $NO"
# fi