syntax on
colorscheme desert
set number

" Copy on system clipboard
set clipboard=unnamedplus

nnoremap <silent> <space>td :s/\[\s\]/\[x\]<CR>
nnoremap <silent> <space>tu :s/\[x\]/\[ \]<CR>
nnoremap <silent> <space>tc i[ ]<space>
nnoremap <silent> <space>ts i<tab>[ ]<space>
 
