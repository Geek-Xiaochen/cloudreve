#!/bin/bash

cp $(pwd)/cloudreve.sh /usr/bin
mv /usr/bin/cloudreve.sh /usr/bin/cloudreve

echo "========================="
echo -e "\033[32m 感谢使用Cloudreve自助脚本 \033[0m"
echo -e "\033[32m Author：筱晨~ \033[0m"
echo -e "\033[32m Home：www.svip13.cn\033[0m"
echo -e "\033[32m Version：1.0 \033[0m"
echo -e "\033[32m Github: https://github.com/Geek-Xiaochen/mc_start \033[0m"
echo "========================="
printf "\n"
echo -e "\033[33m 终端输入 cloudreve 调用此脚本\033[0m"
echo -e "\033[32m 1.\033[0m 下载并运行Cloudreve"
echo -e "\033[32m 2.\033[0m 仅运行Cloudreve"
echo -e "\033[32m 3.\033[0m 设置Cloudreve开机启动"
echo -e "\033[32m 4.\033[0m 更新脚本到最新"
echo -e "\033[32m 5.\033[0m 移除本机所有Cloudreve(谨慎操作)"
echo -e "\033[32m 6.\033[0m 切换到Aria2一键安装管理脚本"
echo -e "\033[32m 7.\033[0m 退出脚本"

mkdir /usr/local/bin/cloud/ > /dev/null 2>&1

read -n1 -p "请选择：" num
printf "\n"
echo -e "\033[33m 请稍等... \033[0m"
echo -e "\033[32m 查找Cloudreve目录中... \033[0m"

#搜索Cloudreve文件路径 例如：/root/mc/bedrock_server
	source=$(find /* -name "cloudreve"  | grep -v "proc" | awk '{printf $1 "\t" }'  | cut -f 1)
#提取Cloudreve文件位置 例如：/root/mc/
	route=$(find /* -name "cloudreve"  | grep -v "proc" | awk '{printf $1 "\t" }'  | cut -f 1 | sed '$ s/cloudreve//' )
echo -e "\033[32m 查找已结束！ \033[0m"


case $num in
    "1")

    printf "\n"
	echo -e "\033[33m请选择系统架构 \033[0m"
	echo -e "\033[32m 1.\033[0m AMD64架构"
	echo -e "\033[32m 2.\033[0m ARM架构"
	echo -e "\033[32m 3.\033[0m ARM64架构"
 	read -n1 -p "请选择：" jiagou

 	apt install wget -y > /dev/null 2>&1
 	yum install wget -y > /dev/null 2>&1

 	case $jiagou in
    "1")

	wget http://www.svip13.cn/sh/cloudreve/cloudreve_for_amd64.tar.gz
	mv cloudreve_for* /usr/local/bin/cloud/
	
    ;;
	"2")
	
	wget http://www.svip13.cn/sh/cloudreve/cloudreve_for_arm.tar.gz
	mv cloudreve_for* /usr/local/bin/cloud/
	
	;;
	"3")

	wget http://www.svip13.cn/sh/cloudreve/cloudreve_for_arm64.tar.gz
	mv cloudreve_for* /usr/local/bin/cloud/

	
	;;
	"*")
	echo -e "\033[32m 输入错误，请重新启动此脚本！ \033[0m"
	exit 11;
	
	;;
	esac
	
	cd /usr/local/bin/cloud/
	echo -e "\033[32m 下载已完成！ \033[0m"
	tar -zxvf cloudreve_for_*  > /dev/null 2>&1
	chmod +x cloudreve 
	echo -e "\033[32m 启动成功！ \033[0m"
	echo -e "\033[32m 请手动选择开机启动！ \033[0m"
	./cloudreve

    ;;
    "2")

	$source
	
	;;
    "3")

		echo "
[Unit]
Description=筱晨Cloudreve开机自启动
After=sshd.service
[Service]
WorkingDirectory=$route
Type=forking
ExecStart=$source
[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/cloudreve.service

		sudo systemctl daemon-reload > /dev/null 2>&1
		sudo systemctl enable cloudreve.service > /dev/null 2>&1
		echo -e "\033[32m 设置开机自启动成功 \033[0m"

    ;;
    "4")
    rm $(pwd)/mc.sh
    wget https://www.svip13.cn/sh/cloudreve/cloudreve.sh > /dev/null 2>&1 && chmod +x cloudreve.sh
    echo -e "\033[31m 已更新至最新版本！ \033[0m"
    bash cloudreve.sh
    ;;
    "5")
	echo -e "\033[31m 误删文件与作者无关 \033[0m"
	read -n1 -p "任意键继续 "
	rm -ivr $route
	rm -ivrf /etc/systemd/system/cloudreve.service
     echo -e "\033[31m 已删除源文件 \033[0m"
     echo -e "\033[31m 请自行删除存储路径 \033[0m"
	;;
    "6")

	apt install curl ca-certificates -y > /dev/null 2>&1
	yum install curl ca-certificates -y > /dev/null 2>&1
	wget -N https://www.svip13.cn/sh/cloudreve/aria2.sh && chmod +x aria2.sh
	./aria2.sh
	
    ;;
    "7")

    	echo -e "\033[32m 反馈建议请致件：hbsyzxc@aliyun.com \033[0m"
	echo -e "\033[32m 已退出此脚本 \033[0m"

		
    ;;
    *)
    	echo -e "\033[32m 反馈建议请致件：hbsyzxc@aliyun.com \033[0m"
	echo -e "\033[32m 输入错误，请重新执行此脚本 \033[0m"
    ;;
esac
