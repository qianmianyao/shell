#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

zsh_install(){
read -p " 请问是否安装zsh [yes/no]: " no1
if [ $no1 = "yes"  ];then
	yum install -y wget git vim
	yum install -y epel-release && yum install -y zsh
	chsh -s /bin/zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"		
fi
	}

zsh_start(){
read -p " 安装zsh插件并且修改配置 [yes/on]: " no2
if [ $no2 = "yes" ];then
	echo -e "${yellow} 下载代码自动补全... ${font}"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions	
	echo -e "${yellow} 下载代码高亮... ${font}"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#-------下面有问题 sed无法替换字符串
	        #启动自动补全和高亮
        a=`grep "plugins=.*" ~/.zshrc | cut -d "=" -f 2`
        b='(git zsh-autosuggestions zsh-syntax-highlighting)'
        sed -i "s!$a!$b!" ~/.zshrc

        #修改自动补全颜色
        c=`grep "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=.*" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh | cut -d "'" -f 2`
        d='fg=cyan'
        sed -i "s!$c!$d!" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

        #z自定义修改
        e=`grep "PROMPT=.*" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme | cut -d "'" -f 2`
        f='%{$fg_bold[yellow]%}%n@%m ${ret_status} %{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'
        sed -i "s!$e!$f!" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

#-------上面有问题 sed无法替换字符串
	source ~/.zshrc
fi
	}
	
	
zsh_uninstall(){
read -p "确定要卸载zsh吗？ [yes/no]" un1
if [ $un1 = "yes" ];then
	rm -rf ~/.oh-my-zsh
	rm -rf ~/.zshrc
	rm -rf ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	rm -rf ~/.oh-my-zsh/themes/robbyrussell.zsh-theme
	chsh -s /bin/bash
	echo -e "${green} 卸载完成 ${font}"
else
	exit 1
fi
	}
	

	
echo -e "${green} 输入1安装zsh ${font}"
echo -e "${green} 输入2启动并且配置zsh ${font}"
echo -e "${green} 输入3卸载zsh ${font}"

start_man(){
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
start_man




