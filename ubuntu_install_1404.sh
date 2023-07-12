#!/bin/bash
# Install on ubuntu 14.04
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install git -y
sudo apt-get install vim -y
wget http://tamacom.com/global/global-6.3.3.tar.gz
cd global-6.3.3
sudo ./configure && make
sudo make install && cd
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone https://github.com/scwuaptx/vimrc

cd vimrc
cp .vimrc ~/.vimrc
vim +PluginInstall +qall
cd ~/.vim/bundle/vimproc.vim/
make
cd vimrc
sudo apt-get install python-fontforge -y
wget https://github.com/Lokaltog/powerline-fonts/raw/master/UbuntuMono/Ubuntu%20Mono%20derivative%20Powerline.ttf
~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher Ubuntu\ Mono\ derivative\ Powerline.ttf
cd
mkdir ~/.fonts
cp vimrc/*Powerline-Powerline.ttf ~/.fonts/
sudo fc-cache -vf
vim +PowerlineClearCache +qall
cp -rf vimrc/snippets ~/.vim/

sudo apt-get install g++ -y
sudo apt-get install python3-all -y
sudo apt-get build-essential
sudo apt-get install vlc -y
sudo apt-get install filezilla -y
sudo apt-get upgrade -y