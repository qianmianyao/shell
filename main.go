package main

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
)

func main() {

	downloadDir := os.Args[1]
	targetDir := os.Args[2]

	log.Println("下载文件夹路径: ", downloadDir)
	log.Println("目标文件夹路径: ", targetDir)

	if !exists(targetDir) {
		log.Println("目标文件夹创建不存在，即将自动创建")
		if err := os.Mkdir(targetDir, os.ModePerm); err != nil {
			log.Println("目标文件夹创建失败，请手动创建此文件夹")
			os.Exit(0)
		}
	}

	watch, err := fsnotify.NewWatcher()
	if err != nil {
		log.Fatal(err)
	}

	defer watch.Close()

	err = watch.Add(downloadDir)
	if err != nil {
		log.Fatal(err)
	}

	go func() {
		for {
			select {
			case ev := <-watch.Events:
				{
					if ev.Op&fsnotify.Remove == fsnotify.Remove && strings.HasSuffix(ev.Name, ".aria2") {
						log.Println("删除文件: ", ev.Name)
						_, file := filepath.Split(ev.Name)
						fileName := strings.Replace(file, ".aria2", "", -1)
						fileList, err := getAllFile(downloadDir)
						if err != nil {
							log.Println(err)
						}
						var fullFileName = ""
						for _, v := range fileList {
							if strings.Contains(v, fileName) {
								fullFileName = v
								break
							}
						}
						oldPath := fmt.Sprintf("%s/%s", downloadDir, fullFileName)
						newPath := fmt.Sprintf("%s/%s", targetDir, fullFileName)
						if err := os.Rename(oldPath, newPath); err != nil {
							log.Println("文件移动失败: ", err)
						} else {
							log.Println("文件移动完成: ", oldPath+"  -->  "+newPath)
						}
					}
				}
			case err := <-watch.Errors:
				{
					log.Println("error: ", err)
					return
				}
			}
		}
	}()

	select {}
}

func getAllFile(pathname string) ([]string, error) {
	fileList := make([]string, 0)
	rd, err := ioutil.ReadDir(pathname)
	if err != nil {
		return nil, err
	}
	for _, fi := range rd {
		if fi.IsDir() {
			continue
		} else {
			fileList = append(fileList, fi.Name())
		}
	}
	return fileList, nil
}

func exists(path string) bool {
	_, err := os.Stat(path)
	if err != nil {
		if os.IsExist(err) {
			return true
		}
		return false
	}
	return true
}
