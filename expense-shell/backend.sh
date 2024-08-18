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
#disabling the nodejs
dnf module disable nodejs -y &>>$log_name
validate $? "disable nodejs"

dnf module enable nodejs:20 -y &>>$log_name
validate $? "disabled nodejs"

dnf install nodejs -y &>>$log_name
validate $? "installing nodejs"

id expense
if [ $? -eq 0 ]
then 
    echo "user exist and not required to create user"
else 
    useradd expense 
fi

mkdir -p /app &>>$log_name
validate $? "creating of app folder"

rm -rf /tmp/bacend*
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$log_name
validate $? "dowloding the backend code"

cd /app &>>$log_name
validate $? "moving to app folder"

rm -rf /app/*
unzip /tmp/backend.zip
validate $? "unzip the code to app folder"

#cd /app

npm install &>>$log_name
validate $? "installing dependencies"

cp /home/ec2-user/Linux/expense-shell/backend.service /etc/systemd/system/backend.service
#backend schema need to prepare


systemctl daemon-reload &>>$log_name
validate $? "daemon-reload"

systemctl start backend &>>$log_name
validate $? "starting backend"

systemctl enable backend &>>$log_name
validate $? "enabling Backend"

dnf install mysql -y &>>$log_name
validate $? "installation mysql"


#mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl restart backend &>>$log_name
validate $? "restart backend"