#! /bin/bash 

USERID=$(id -u) 

validate(){
    if [ $1 =eq 0 ]
    then 
        echo "the status of $2 installation is sucess"
    else

        echo " the status of $2 installation is failure "
    }

if [ "$USERID" -eq 0 ]
then 
    echo " you are in super user"
    
else
    echo "you need to change it to su user name"
    exit 1

fi

dnf install mysql -y
validate $? " mysql"

# if [ $? -ne 0 ]
# then 
#     echo "installation script is failure"
#     exit 1
# else 
#     echo "installation is success"
# fi
