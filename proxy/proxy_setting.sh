#!/bin/bash
pc_pwd=
username=
password=
my_proxy=http://${username}:${password}@proxy:80

Green(){
	echo -e '\033[1;32m'$1'\033[0;39m'
}
Yellow(){
	echo -e '\033[1;33m'$1'\033[0;39m'
}

# Docker proxy setting
docker_set_proxy(){
    Green "* Docker set proxy..."
    echo ${pc_pwd} | sudo -S cp Quanta.crt /usr/local/share/ca-certificates/Quanta.crt
    echo ${pc_pwd} | sudo -S sudo update-ca-certificates

    if [ ! -d "docker.service.d" ];then
        echo ${pc_pwd} | sudo -S mkdir /etc/systemd/system/docker.service.d
    fi
    echo ${pc_pwd} | sudo -S cp proxy.conf /etc/systemd/system/docker.service.d/proxy.conf
    echo ${pc_pwd} | sudo -S cp daemon.json /etc/docker/

    echo ${pc_pwd} | sudo -S systemctl daemon-reload
    echo ${pc_pwd} | sudo -S systemctl restart docker

    docker login -u ${username} -p ${password} bu11-sw-nexus01:8082
}

# Git proxy setting
git_set_proxy(){
    Green "* Git set proxy..."
    git config --global https.proxy ${my_proxy}
    git config --global http.proxy ${my_proxy}
    git config --global remote.origin.proxy ${my_proxy}
    git config --global http.sslVerify false
}

git_unset_proxy(){
    Yellow "* Git remove proxy..."
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    git config --global --unset http.sslVerify
    git config --global --unset remote.origin.proxy
}

# APT proxy setting
apt_set_proxy(){
    Green "* APT set proxy..."
    fpath=/etc/apt/apt.conf
    echo "Acquire::http::proxy '${my_proxy}';" > ${fpath}
    echo "Acquire::https::proxy '${my_proxy}';" >> ${fpath}
    echo "Acquire::ftp::proxy 'ftp://${username}:${password}@proxy:80/';" >> ${fpath}
    echo "Acquire::socks::proxy 'socks://${username}:${password}@proxy:80/';" >> ${fpath}
}

# HTTP proxy setting
https_set_proxy(){
    echo HTTP set proxy...
    export GLOBAL_AGENT_HTTPS_PROXY=${my_proxy}
}

# Npm proxy setting
npm_set_proxy(){
    Green "* NPM set proxy..."
    npm config --global set proxy ${my_proxy}
    npm config --global set https-proxy ${my_proxy}
    npm config --global set strict-ssl false
    npm config set proxy ${my_proxy}
    npm config set https-proxy ${my_proxy}
    npm config set strict-ssl false
    export ELECTRON_GET_USE_PROXY=true
}

npm_unset_proxy(){
    Yellow "* NPM remove proxy..."
    npm config --global rm proxy
    npm config --global rm http-proxy
    npm config --global rm https-proxy
    npm config rm proxy
    npm config rm http-proxy
    npm config rm https-proxy
}

git_set_proxy
docker_set_proxy
https_set_proxy
npm_set_proxy
