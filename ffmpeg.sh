#!/bin/bash

#颜色样式
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

echo -e "${green}#=========================一键安装ffmpeg==========================#${font}"
echo -e "${green}#   System Required: CentOS7${font}"
echo -e "${green}#   Website: https://qianmianyao.cn${font}"
echo -e "${green}#=================================================================#${font}"
echo -e "${yellow}安装ffmpeg${font}"
#静态安装ffmpeg
install_ffmpeg(){
	echo -e "${read}依赖安装中...${font}"
	yum install -y epel-release
	yum install -y wget
	a='https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz'
	b='https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-i686-static.tar.xz'
	c='https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-arm64-static.tar.xz'
	echo -e "${green}1.amd64${font}"
	echo -e "${green}2.i686${font}"
	echo -e "${green}3.arm64${font}"
	read -p "输入你需要的版本[1&2&3]:" ban
	case $ban in
	1)
	wget -N $a
	;;
	2)
	wget -N $b
	;;
	3)
	wget -N $c
	;;
	*)
	echo "输入正确版本"
	exit 1
	;;	
	esac     
	tar xvf ffmpeg-git-*-static.tar.xz && rm -rf ffmpeg-git-*-static.tar.xz
	mv ffmpeg-git-*/ffmpeg /usr/bin/
	mv ffmpeg-git-*/ffprobe /usr/bin/
if [ -e "/usr/bin/ffmpeg" -a  -e "/usr/bin/ffprobe"  ];then
        echo -e "${green}ffmpeg安装成功${font}"
else
        echo "${red}ffmpeg安装失败${font}"
fi
}
install_ffmpeg
