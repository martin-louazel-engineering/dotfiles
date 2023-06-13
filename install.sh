#!/bin/bash

sudo apt install \
	curl \
	vim \
	xterm \
	tmux \
	xclip \
	fonts-powerline \
	zsh \
	fzf \
	ranger \
	rofi \
	libx11-dev libxtst-dev python3-docopt python3-xlib python3-pil python3-attr \
	ueberzug

git config --global core.editor "vim"
git config --global user.name "Martin Louazel"
read email -p "Enter git email address:"
read yn -p "Confirm $email ? (y/n)"
if [ "$yn" = "y" ];then
	git config --global user.email $email
fi

# Initialize tpm
git submodule update --init

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Zsh - PowerLevel10k
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Zsh - Synthax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh - Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Remap Caps Lock to Ctrl ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
	setxkbmap -option ctrl:nocaps
fi
