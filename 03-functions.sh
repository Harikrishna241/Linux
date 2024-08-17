#! /bin/bash 

USERID=$(id -u) 

validate(){
    echo "the status of the script:$1"
    echo " $2 "
}

if [ "$USERID" -eq 0 ]
then 
    echo " you are in super user"
    
else
    echo "you need to change it to su user name"
    exit 1

fi

dnf install mysql -y
validate $? "installation of mysql"

# if [ $? -ne 0 ]
# then 
#     echo "installation script is failure"
#     exit 1
# else 
#     echo "installation is success"
# fi
