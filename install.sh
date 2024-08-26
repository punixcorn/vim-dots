#!/bin/bash

echo "[+] Installing vim Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[+] Installing Dependencies"
if -f /bin/pacman; then
    sudo pacman -S git nodejs git npm
elif -f /bin/apt; then 
    sudo apt install git nodejs npm
fi


echo "[+] Installing css formatter"
sudo npm install -g js-beautify

echo "[+] Installing html formatter"
sudo npm install -g js-beautify

echo "[+] Installing lua & shell formatter"
[ -f /bin/pacman ] && sudo pacman -S stylua shfmt tidy
[ -f /bin/apt ] && sudo apt install shfmt tidy

echo "[+] Installing typescript and js formmater"
[ -f /bin/pacman ] && sudo pacman -S prettier astyle 
[ -f /bin/apt ] && sudo apt install astyle && sudo npm install -g prettier 

if -f /bin/go; then
    echo "[-]  Could not find go"
    echo "[+]  Installing go"
    [ -f /bin/pacman ] && sudo pacman -S go
    [ -f /bin/apt ] && sudo apt install go

fi

echo "[+] Installing Go formatter"
sudo go install mvdan.cc/gofumpt@latest
