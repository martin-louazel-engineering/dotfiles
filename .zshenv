alias gti='gittree'
alias gt='git log --graph --oneline --decorate'

gittree() {
	vim -c "Git ++curwin --paginate log --oneline --graph --decorate $@"
}
