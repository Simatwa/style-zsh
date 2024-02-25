#!/bin/bash

SLEEP_TIME=10
function out_this() {
    echo ">> [*] $@"
}

if [ -n "$IGNORE_ERROR" ]; then
  out_this "Exceptions will be ignored"
else
  set -e
fi


out_this "Installing required packages"  

if [ -d "/data/data/com.termux/files/usr/bin" ]; then
   apt install zsh git curl nano -y
else 
   apt install zsh-autosuggestions zsh-syntax-highlighting zsh git curl nano -y
fi




# Install oh-my-zsh

out_this "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://github.com/Simatwa/style-zsh/blob/main/install-oh-my-zsh.sh?raw=true)"


if [ -z "$ZSH_CUSTOM" ]; then
    ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
fi

# Install plugins.

out_this "Installing plugins"

## autosuggesions plugin

out_this "^ Autosuggestions"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

## zsh-syntax-highlighting plugin

out_this "^ Syntaz-highlighting"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

## zsh-fast-syntax-highlighting plugin

out_this "^ fast-syntax-highlighting"

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

## zsh-autocomplete plugin

out_this "^ Autocomplete"

git clone --depth  1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

# Enable plugins by adding them to .zshrc.

echo "\
    Open ~/.zshrc

    Find the line which says plugins=(git).

    Replace that line with:
     plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

    Recommended themes :
     bira, rkj-repos
     "

echo "Auto-opening config file in $SLEEP_TIME s"
sleep $SLEEP_TIME
nano ~/.zshrc

out_this "Launching zsh"
zsh