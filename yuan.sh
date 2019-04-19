#!/bin/bash
#颜色样式 
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"
echo -e "${green}--------------------------一键换源---------------------------------${font}"
echo -e "${green}#   System Required: CentOS7${font}"
echo -e "${green}#   Website: https://qianmianyao.cn${font}"
echo -e "${green}---------------------------------------------------------------------${font}"
echo -e "${yellow}一键换源${font}"

epel(){
	yum install -y epel*
}

ali(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	yum makecache
}

wy(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
	yum makecache
}

tuna(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/zp1998421/shell/master/yuan/tuna
	yum makecache
}

mun(){
	echo -e "${green}1.安装epel源${fond}"
	echo -e "${green}2.安装阿里源${fond}"
	echo -e "${green}3.安装163源${fond}"
	echo -e "${green}4.安装清华源${fond}"
	read -p "选择[1,2,3,4]"yum_install
	case $yum_install in
		1)
		epel
		;;
		2)
		ali
		;;
		3)
		wy
		;;
		4)
		tuna
		;;
		*)
		mv /etc/yum.repos.d/CentOS-Base.repo.backup /etc/yum.repos.d/CentOS-Base.repo
		exit 1
		;;
	esac
}

start(){
	if [ -e "/etc/redhat-release" ];then
		yum install -y wget
		mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
		mun
	else
		echo -e "请使用centos7"
		exit 2
	fi
}
start
