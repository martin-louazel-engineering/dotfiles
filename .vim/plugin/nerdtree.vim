let NERDTreeWinSize=40
let NERDTreeShowHidden=1

function! CustomNerdTreeToggle()
	if filereadable(expand('%'))
		execute "NERDTreeToggle %:p:h"
	else
		execute "NERDTreeToggleVCS"
	endif
endfunction
nnoremap <leader>e :call CustomNerdTreeToggle()<CR>

