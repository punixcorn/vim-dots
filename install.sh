#!/bin/bash

echo "[+] Installing vim Plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[+] Installing Dependencies using package manager"
if [[ -f /bin/pacman ]]; then
    prettier=""
    sudo pacman -S git nodejs git npm go stylua shfmt tidy prettier astyle
elif [[ -f /bin/apt ]]; then
    prettier="prettier"
    sudo apt install shfmt tidy git nodejs npm astyle go
fi

echo "[+] Installing npm packages"
sudo npm install -g js-beautify $prettier

echo "[+] Installing Go formatter"
sudo go install mvdan.cc/gofumpt@latest
