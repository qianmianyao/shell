#!/bin/bash

#颜色样式
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

echo -e "${green}#=================================================================#${font}"
echo -e "${green}#   System Required: CentOS7${font}"
echo -e "${green}#   Description: 常用工具安装${font} V1.0"
echo -e "${green}#   Author: devil${font}"
echo -e "${green}#   Website: https://devil.moe${font}"
echo -e "${green}#=================================================================#${font}"
#安装常用组件
ofthe_yum(){
	yum install -y epel-release
	yum install -y vim
	yum install -y git
	yum install -y wget
}


#静态安装ffmpeg
install_ffmpeg(){
	wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
	tar xvf ffmpeg-git-*-static.tar.xz && rm -rf ffmpeg-git-*-static.tar.xz
	mv ffmpeg-git-*/ffmpeg /usr/bin/
	mv ffmpeg-git-*/ffprobe /usr/bin/
if [ -e "/usr/bin/ffmpeg" -a  -e "/usr/bin/ffprobe"  ];then
        echo -e "${green}ffmpeg安装成功${font}"
else
        echo "${red}ffmpeg安装失败${font}"
fi
}

echo -e "${yellow}1.安装ffmpeg${font}"
#目录选项
start_manu(){
	read -p "输入正确选项：" manu
	case $manu in
	1)
	install_ffmpeg
	;;
	2)
	ofthe_yum
	;;
	*)
	exit 1
	;;
	esac
	}
	
start_manu