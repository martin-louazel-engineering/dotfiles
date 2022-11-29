alias gti='gittree'
alias gt='git log --graph --oneline --decorate'

gittree() {
	args="$*"
	nvim -c "Git ++curwin --paginate log --oneline --graph --decorate $args"
}
