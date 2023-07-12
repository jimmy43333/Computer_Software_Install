#!/bin/bash
# Run on 18.04
Yellow='\e[1;33m'
Green='\e[1;32m'

# if [ -z ${1} ] ; then
#         echo please input your project
#         exit 0
# fi

basic_install(){
	sudo apt-get update
	echo -e "${Yellow} -----<< Installing git >>----- \e[0m"
	sudo apt-get install -y git
	sleep 2
	echo -e "${Yellow} -----<< Installing vim >>----- \e[0m"
	sudo apt-get install -y vim
	sleep 2
	echo -e "${Yellow} -----<< Installing python3 >>----- \e[0m"
	sudo apt-get install -y python3-pip
	sleep 2
	echo -e "${Yellow} -----<< Installing python >>----- \e[0m"
	sudo apt-get install -y python-pip
	sleep 2
	echo -e "${Yellow} -----<< Installing net-tools >>----- \e[0m"
	sudo apt-get install -y net-tools
	sleep 2
	echo -e "${Yellow} -----<< Installing openssh-server >>----- \e[0m"
	sudo apt-get install -y openssh-server
	sleep 2
	echo -e "${Yellow} -----<< Installing minicom >>----- \e[0m"
        sudo apt-get install -y minicom
        sleep 2
        echo -e "${Yellow} -----<< Installing docker >>----- \e[0m"
        sudo apt-get install -y docker.io
	sleep 1
        sudo groupadd docker
	sleep 1
        sudo usermod -aG docker $USER
	echo $USER
	sleep 2
	echo -e "${Green} -----<< Installing Finish >>----- \e[0m"
	echo -e "${Yellow}== Please run \"service docker status\" == \e[0m"
}

version_check(){
	echo -e "${Yellow} -----<< Check version >>----- \e[0m"
	echo -e "${Green} Git version \e[0m"
	git --version
	sleep 1
	echo -e "${Green} Docker version \e[0m"
	docker --version
	sleep 1
	echo -e "${Green} python3 version \e[0m"
	python3 --version
	sleep 1
	echo -e "${Green} python version \e[0m"
	python --version
	sleep 1
	echo -e "${Green} vim version \e[0m"
	vim --version
	sleep 1
	echo -e "${Green} openssh server version \e[0m"
	ssh -V
	sleep 1
	echo -e "${Green} anydesk version \e[0m"
	anydesk --version
	echo " "
	sleep 1
	echo -e "${Green} minicom version \e[0m"
	minicom --version
}

basic_install
version_check


