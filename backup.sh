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
# crontab -e

# #开启定时服务，一般是默认开启的
# service crond start
# 编辑添加定时任务
# nano crontab -e
# #每十分钟运行一次脚本
# */10 * * * *
# #每天凌晨1点30分执行脚本，把下面的脚本输入到crontab -e里面
# 30 01 * * * /root/backup.sh

# #第一次执行时，进入root目录
# cd /root/
# #clone服务器目录
# git clone git@github.com:279192434/backup.git

cd /root/backup/
git add .
git commit -m "vos数据库备份"
git branch -M main
git remote add origin git@github.com:279192434/backup.git
git push -u origin main

