#!/bin/bash
echo "#=================================================================#"
echo "#   System Required: CentOS7"
echo "#   Description: zsh_install"
echo "#   Author: devil"
echo "#   Website: https://devil.moe"
echo "#=================================================================#"
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#颜色样式
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

#安装需要的软件
zsh_install(){
read -p " 请问是否安装zsh [yes/no]: " no1
if [ $no1 = "yes"  ];then
	yum install -y wget git vim
	yum install -y epel-release && yum install -y zsh
	chsh -s /bin/zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"		
	
fi
	}

#修改自定义的配置文件
zsh_start(){
read -p " 安装zsh插件并且修改配置 [yes/on]: " no2
if [ $no2 = "yes" ];then
	echo -e "${yellow} 下载代码自动补全... ${font}"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions	
	echo -e "${yellow} 下载代码高亮... ${font}"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	#启动自动补全和高亮
        a=`grep "plugins=.*" ~/.zshrc | grep -v "rail.*"  |cut -d "(" -f 2 | cut -d ")" -f 1`
	b='git zsh-autosuggestions zsh-syntax-highlighting'
	sed -i "s/$a/$b/" ~/.zshrc
        #修改自动补全颜色
        c=`grep "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=.*" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh | cut -d "'" -f 2 | cut -d "=" -f 2`
        d='cyan'
        sed -i "s/$c/$d/g" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	#
	#修改环境变量
	#w='%{$fg_bold[yellow]%}%n@%m'
	#PROMPT="$PROMPT"$w
	#
	source ~/.zshrc
fi
	}
	
#卸载zsh,删除目录并且切换成bash	
zsh_uninstall(){
read -p "确定要卸载zsh吗？ [yes/no]" un1
if [ $un1 = "yes" ];then
	rm -rf ~/.oh-my-zsh
	rm -rf ~/.zshrc
	rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	rm -rf ~/.oh-my-zsh/themes/robbyrussell.zsh-theme
	echo -e "${green} 卸载完成 ${font}"
	chsh -s /bin/bash
else
	exit 1
fi
	}
	

#选项菜单	
echo -e "${green} 1.安装zsh ${font}"
echo -e "${green} 2.配置zsh ${font}"
echo -e "${red} 3.卸载zsh ${font}"

start_manu(){
	read -p " 请输入正确的数字1&2&3 : " man
	case "$man" in
		1)
		zsh_install
		;;
		2)
		zsh_start
		;;
		3)
		zsh_uninstall
		;;
		*)
		echo -e  "${yellow} 请输入正确数字! ${font}"
		;;
	esac
	}
	
#启动目录
start_manu




