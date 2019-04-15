#!/bin/bash
 
#颜色样式
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
font="\033[0m"

echo -e "${green}#=========================一键安装python3==========================#${font}"
echo -e "${green}#   System Required: CentOS7${font}"
echo -e "${green}#   Website: https://qianmianyao.cn${font}"
echo -e "${green}#=================================================================#${font}"
echo -e "${yellow}安装python3${font}"

download(){
	yum install update
	yum install -y gcc*
	yum install -y openssl-devel
  #python3.7
	wget -N https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
  #setuptools
	wget -N https://files.pythonhosted.org/packages/ed/69/c805067de1feedbb98c53174b0f2df44cc05e0e9ee73bb85eebc59e508c6/setuptools-41.0.0.zip
  #pip
	wget -N https://files.pythonhosted.org/packages/36/fa/51ca4d57392e2f69397cd6e5af23da2a8d37884a605f9e3f2d3bfdc48397/pip-19.0.3.tar.gz
	tar -zxvf Python-3.7.3.tgz
	tar -zxvf pip-19.0.3.tar.gz
	unzip setuptools-41.0.0.zip
}

install_python3(){
	cd Python-3.7.3
	./configure --prefix=/usr/local/python3 --with-ssl
	make && make install
	cd /usr/local/python3/bin
	ln -s /usr/local/python3/bin/python3.7 /usr/local/bin/python3
	if [ -f "/usr/local/bin/python3"];then
		echo "python3安装完成"
	else
		echo "未检测到文件，可能安装失败"
	fi
}

install_pip(){
	cd ~
	cd setuptools-41.0.0
	python3 setup.py build && python3 setup.py install
	cd ..
	cd pip-19.0.3
	python3 setup.py build && python3 setup.py install
	cd /usr/local/python3/bin
	ln -s /usr/local/python3/bin/pip /usr/local/bin/pip3
	if [ -f "/usr/local/bin/pip3"];then
		echo "pip3安装成功"
	else
		echo "文件未找到，可能安装失败"
	fi
}

unintall_python(){
	rm -rf /usr/local/bin/pip
	rm -rf /usr/local/bin/python3
	rm -rf /usr/local/python3
	echo -e "${read}python3卸载成功${font}"
}


start(){
	echo -e "${green}1.install python3${font}"
	echo -e "${green}2.install pip3${font}"
	echo -e "${green}3.uninstall python3;pip${font}"
	read -p "1&2&3:" install
	case $install in
	1)
	install_python3
	;;
	2)
	install_pip
	;;
	3)
	uninstall_python3
	;;
	*)
	echo "输入选项"
	exit 1
	;;
	esac
}
start
