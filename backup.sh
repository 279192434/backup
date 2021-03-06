#!/bin/bash
#中文-UTF8

#获取当前时间
dateTime=`date +%Y%m%d`

# 停止vos备份数据库全部文件
service vos3000d stop
service mbx3000d stop
service callserviced stop
service mysql stop
tar czvf /root/backup/vos3000-mysql$dateTime.tar /var/lib/mysql/vos3000

# 删除该文件夹下超过五天的文件
find ./ -mtime +5 -name "*.tar" -exec rm -rf {} \;

# 启动vos系统
service vos3000d start
service mbx3000d start
service callserviced start
service mysql start

# #给自动备份脚本加执行权限
# chmod 777 backup.sh

# #利用系统crontab实现每天自动运行
# #安装cron服务
# yum install -y vixie-cron
# yum install crontabs

# #把crond服务添加到系统启动项
# chkconfig crond on
# #开启定时服务，一般是默认开启的
# service crond start
# #检查crontab服务是否启动：
# #service crond status
# #查看本机的所有定时任务
# #tail -f /var/log/cron

# 编辑添加定时任务
# crontab -e
# #每十分钟运行一次脚本
# */10 * * * *
# #每天凌晨1点30分执行脚本，把下面的脚本输入到crontab -e里面
# 30 01 * * * /root/backup.sh

# #第一次执行时，进入root目录，安装git，这是默认是centos系统
# cd /root/
# yum install -y git
# #输入以下命令一直回车，email为你在github上注册的邮箱
# ssh-keygen -t rsa -C "email"
# #打开当前目录.ssh/文件夹，可以看到id_rsa.pub这个文件
# cat id_rsa.pub
# 复制id_rsa.pub里面的密钥
# 登录github，在github里选择setting,然后选择SSH and GPG keys再选择New SSH keys，添加密钥保存即可
# #克隆服务器目录到本地
# git clone https://github.com/279192434/backup.git
# git clone git@github.com:279192434/backup.git

cd /root/backup/
git add .
git commit -m "vos数据库备份"
git branch -M main
git remote add origin git@github.com:279192434/backup.git
git push -u origin main

