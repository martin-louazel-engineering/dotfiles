execute pathogen#infect()

syntax on
filetype plugin indent on
colorscheme desert

let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
" let g:airline_solarized_bg='dark'


set number

" Copy on system clipboard
set clipboard=unnamedplus

nnoremap <silent> <space>td :s/\[\s\]/\[x\]<CR>
nnoremap <silent> <space>tu :s/\[x\]/\[ \]<CR>
nnoremap <silent> <space>tc i[ ]<space>
nnoremap <silent> <space>ts i<tab>[ ]<space>
 
