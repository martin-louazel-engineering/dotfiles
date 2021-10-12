shopt -s expand_aliases

# Aliases
alias gittree='git log --graph --oneline --color=auto --decorate'
alias please='sudo $(history -p !!)'

#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach -t default || tmux new -s default
#fi

bind '"\e[6~": menu-complete'
bind '"\e[5~": menu-complete-backward'

LOCATION='\[\033[01;34m\]`pwd | sed "s#$HOME#~#g"  | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:'$LOCATION'\[\033[00m\]\$ '

bind 'set show-all-if-ambiguous on'
bind 'set bell-style visible'
