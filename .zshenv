alias gti='gittree'
alias gt='git log --graph --oneline --decorate'

gittree() {
	args="$*"
	vim -c "GT $args"
}
. "$HOME/.cargo/env"
