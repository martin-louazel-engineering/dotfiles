#!/bin/bash

sudo apt install \
	vim \
	xterm \
	tmux \
	xclip \
	fonts-powerline \
	zsh \
	fzf \
	ranger

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Zsh - PowerLevel10k
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Zsh - Synthax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Zsh - Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Remap Caps Lock to Ctrl ? (y/n)"
read answer
if [ "$answer" = "y" ]; then
	setxkbmap -option ctrl:nocaps
fi
