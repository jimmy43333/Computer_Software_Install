#!/bin/bash
pwd=citeambu15

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

install_aptget_package(){
	echo ${pwd} | sudo -S apt-get update
	package_list=("git" "vim" "python3" "python3-pip" "python3-tk" "net-tools" "openssh-server" "minicom" "docker.io" "sshpass" "curl" 
		      "node" "npm")
	for ele in ${package_list[@]}
	do
		Yellow "----- Installing ${ele} -----"
		echo ${pwd} | sudo -S DEBIAN_FRONTEND=noninteractive apt-get install -y ${ele}
		sleep 1
	done
	Orange "Change Docker usermod....."
	echo ${pwd} | sudo -S groupadd docker
	sleep 1
    echo ${pwd} | sudo -S usermod -aG docker $USER
}

install_docker_compose_package(){
	Yellow "----- Installing docker-compose -----"
	if [ -f "docker-compose" ];then
		echo Docker-compose file exist !!
	else
		usrname=10808203
		password=citeamBU15-03
		# get latest docker compose released tag
		COMPOSE_VERSION=$(curl -x "http://$usrname:$password@proxy:80" -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
		echo Latest Version: ${COMPOSE_VERSION}
		# download docker-compose
		curl -x "http://$usrname:$password@proxy:80" -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o docker-compose
	fi
	echo ${pwd} | sudo -S chmod +x docker-compose
	echo ${pwd} | sudo -S cp docker-compose /usr/local/bin/docker-compose
	# sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
}

install_vscode_package(){
	Yellow "----- Install VSCode package -----"
	
	if [ ! -f "code_latest.deb" ];then
		Orange "Download vscode ..."
		usrname=10808203
		password=citeamBU15-03
		curl -x "http://$usrname:$password@proxy:80" -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o code_latest.deb
	fi
	echo ${pwd} | sudo -S dpkg -i code_latest.deb
}

install_yaml_package(){
	Yellow "----- Install YAML package -----"
	if [ -f "pyyaml_5.3.orig.tar.gz" ];then
		tar zxvf pyyaml_5.3.orig.tar.gz
		cd PyYAML-5.3
		echo ${pwd} | sudo -S python3 setup.py install
		cd ..
		echo ${pwd} | sudo -S rm -rf PyYAML-5.3/
	else
		Red "----- Fail: Can not find file pyyaml_5.3.orig.tar.gz -----"
	fi
}

install_nvm_package(){
	curl -x "http://$usrname:$password@proxy:80" -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source ~/.bashrc
}


version_check(){
	Yellow "----- Check version -----"
	Green "* Git version"
	git --version
	Green "* Curl version"
	curl -V | head -1
	Green "* Docker version"
	docker --version
	Green "* Docker compose"
	docker-compose --version
	Green "* Python3 version"
	python3 --version
	Green "* Python version"
	python --version
	Green "* PyYAML version"
	pip3 freeze | grep PyYAML
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
	Green "* SSHpass version"
	sshpass -V | head -1
	Green "* Nodejs"
	node -v
	Green "* NPM"
	npm -v
	Green "* NVM"
	nvm -v
}

if [ "${1}" == "check" ];then
	version_check
else
	install_aptget_package
	install_vscode_package
	install_docker_compose_package
	install_nvm_package
	version_check
fi


