#!/bin/bash
centos(){
	if [ -e /etc/redhat-release ];then
		start
	else
		echo -e "请使用centos7"
		exit 2
	fi
}
yum install -y wget
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
yum_epel(){
	yum install -y epel*
}

yum_ali(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	yum makecache
}

yum_163(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
	yum makecache
}

yum_tuna(){
	wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/zp1998421/shell/master/yuan/tuna
	yum makecache
}

start(){
	echo -e "${green}1.安装epel源${fond}"
	echo -e "${green}2.安装阿里源${fond}"
	echo -e "${green}3.安装163源${fond}"
	echo -e "${green}4.安装清华源${fond}"
	read -p "选择[1,2,3,4]"yum_install
	case $yum_install in
		1)
		yum_epel
		;;
		2)
		yum_ali
		;;
		3)
		yum_163
		;;
		4)
		yum_tuna
		;;
		*)
		mv /etc/yum.repos.d/CentOS-Base.repo.backup /etc/yum.repos.d/CentOS-Base.repo
		exit 1
		;;
	esac
}

root
