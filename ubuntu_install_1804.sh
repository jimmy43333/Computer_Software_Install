#!/bin/bash
pwd=citeambu11

Yellow(){
	echo -e '\033[1;33m'$1'\033[0;39m'
}
Green(){
	echo -e '\033[1;32m'$1'\033[0;39m'
}
Orange(){
	echo -e '\033[0;33m'$1'\033[0;39m'
}
Red(){
	echo -e '\033[1;31m'$1'\033[0;39m'
}

aptget_package(){
	echo ${pwd} | sudo -S apt-get update
	package_list=("git" "vim" "python3" "python3-pip" "net-tools" "openssh-server" "minicom" "docker.io")
	for ele in ${package_list[@]}
	do
		Yellow "----- Installing ${ele} -----"
		echo ${pwd} | sudo -S apt-get install -y ${ele}
		sleep 1
	done
	Orange "Change Docker usermod....."
	echo ${pwd} | sudo -S groupadd docker
	sleep 1
    echo ${pwd} | sudo -S usermod -aG docker $USER
}

version_check(){
	Yellow "----- Check version -----"
	Green "* Git version"
	git --version
	Green "* Docker version"
	docker --version
	Green "* Python3 version"
	python3 --version
	Green "* Python version"
	python --version
	Green "* Vim version"
	vim --version | head -1
	Green "* Openssh server version"
	ssh -V
	sleep 1
	Green "* Anydesk version"
	anydesk --version
	echo " "
	Green "* Minicom version"
	minicom --version | head -1
}

ats_docker_image(){
	Yellow "----- Load ATS docker image -----"
	image_list=("bu11-sw-nexus01:8082/ros2:v3.1" "node:16.14.0-slim")
	tar_list=("bu11-sw-nexus01_ros2_v3_1.tar" "node-16.14.0-slim.tar")
	check_sum=("a89cca74cf8d74445007b8123548127e" "3a42fe65914e6799795f3092f8005af0")

	cd ~/Desktop
	for i in ${!image_list[@]}
	do
		Orange "* Load docker image ${image_list[i]}......"
		i_name=`echo "${image_list[i]}" | rev | cut -d":" -f2-  | rev`
		i_version=`echo "${image_list[i]}" | rev | cut -d":" -f1  | rev`
		# echo ${i_name}
		# echo ${i_version}
		docker images | grep ${i_name} | grep ${i_version}
		if [ $? -eq 1 ];then
			if [ -f ${tar_list[i]} ];then
				md5id=`md5sum ${tar_list[i]} | cut -d" " -f1`
				if [ "${md5id}" == "${check_sum[i]}" ];then
					docker load < ${tar_list[i]}
					docker images | grep ${i_name} | grep ${i_version}
					if [ $? -eq 0 ];then
						Green "----- Load Success -----"
					else
						Red "----- Load Fail -----"
					fi
				else
					Red "----- Fail: ${tar_list[i]} checksum incorrect -----"
					Orange "* Checksum: ${md5id}"
					Orange "* Should be: ${check_sum[i]}"
				fi
			else
				Red "----- Fail: Can not find file ${tar_list[i]} -----"
			fi
		fi
	done
}

setting_usb_config(){
	Yellow "----- Copy 50 rules to /etc/udev/rules.d -----"
	cd ~/Desktop/ATS_Tool/utility
	echo ${pwd} | sudo -S cp 50-usb.rules /etc/udev/rules.d
	echo Reconnect usb device
	echo ${pwd} | sudo -S udevadm trigger
}

setting_serial_authority(){
	Yellow "----- Change mode of /dev/serial/ -----"
	echo ${pwd} | sudo -S chmod 777 /dev/serial/by-id/*
	echo ${pwd} | sudo -S chmod 777 /dev/serial/by-path/*
}

setting_detailLog_folder(){
	dirname=DetailLog
	proj_folder=${dirname}'/'${1}
	cd ~/Desktop
	if [ ! -d ${dirname} ];then
    	Yellow "----- Create DetailLog Folder -----"
    	mkdir ${dirname}
    	echo ${pwd} | sudo -S chmod 777 $dirname
	fi
	if [ ! -d ${proj_folder} ];then
    	Yellow "----- Create ${proj_folder} -----"
    	mkdir ${proj_folder}
    	echo ${pwd} | sudo -S chmod 777 $proj_folder
	fi
}

# for_J51(){
# 	echo -e "${Yellow} -----<< Installing Kvaser CANlib SDK >>-----\e[0m"
# 	sudo apt-get install build-essential
# 	wget --content-disposition "https://www.kvaser.com/download/?utm_source=software&utm_ean=7330130980754&utm_status=latest"
# 	tar xvzf linuxcan.tar.gz
# 	cd linuxcan
# 	make
# 	sudo make install
# 	sudo make load
# 	sleep 1
# }

aptget_package
version_check
# ats_docker_image
# setting_usb_config
# setting_serial_authority
# setting_detailLog_folder ${1}


