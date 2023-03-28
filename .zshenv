alias gti='gittree'
alias gt='git log --graph --oneline --decorate'

gittree() {
	args="$*"
	nvim -c "GT $args"
}
. "$HOME/.cargo/env"
