# Aliases
alias gittree='git log --graph --oneline --all --color=always --decorate | less -r'
alias please='sudo $(history -p !!)'

#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#fi

bind '"\e[6~": menu-complete'
bind '"\e[5~": menu-complete-backward'

