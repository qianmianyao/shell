#!/bin/bash
jieya(){
    read -p "解压密码：" passwd
    read -p "文件后缀：" hz
    for i in *.$hz
    do
    7z x "$i" -p$passwd && rm -rf $i
    done
}

7z(){
    read -p "压缩密码：" passwd2
    for ysb in *;do
    7z a -p$passwd2 "${ysb}.7z" "$ysb"
    done
}

start(){
	read -p " 1.解压|2.压缩 : " man
	case "$man" in
		1)
		jieya
		;;
		2)
		7z
		;;
	esac
	}
start
