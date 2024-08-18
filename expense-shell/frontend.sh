#installation of my sql 
USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
Script_Name=$(echo $0 | cut -d "." -f1)
log_name=/tmp/$Script_Name-$TIMESTAMP.log

#Color coding for the shell scripting output 
R="\e[31m"
G="\e[32m"
NO="\e[0m"

echo "please enter the root passwd"
read -s My_sql_Password
echo "$My_sql_Password"

if [ "$USERID" -eq 0 ]
then 
    echo "you are in super user mode and you can run the script"
else 
    echo "please run the script in su user"
    exit 1
fi
# now i need to check whther the mysql-server install or not 
validate(){
    
    if [ $? -eq 0 ]
    then 
        echo -e "$2 $G successfully $NO "
            
    else
            echo -e "$2 $R failed  $NO"            
    fi

}
#installing the nginx
dnf dnf install nginx -y &>>$log_name
validate $? "Installation  of nginx"

systemctl enable nginx -y &>>$log_name
validate $? "enabling the nginx"

systemctl start nginx &>>$log_name
validate $? " starting the nginx"

rm -rf /usr/share/nginx/html/*
validate $? " removing the nginx files "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$log_name
validate $? "dowloding the frontend code"

cd /usr/share/nginx/html &>>$log_name
validate $? "moving to nginx html folder"

unzip /tmp/frontend.zip
validate $? "unzip the code to app folder"


cp /home/ec2-user/expense.conf /etc/nginx/default.d/expense.conf
#backend schema need to prepare


systemctl restart nginx &>>$log_name
validate $? "daemon-reload"
