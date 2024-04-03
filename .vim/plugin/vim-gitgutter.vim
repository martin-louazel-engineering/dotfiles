set updatetime=500
autocmd vimenter * highlight! link SignColumn LineNr
autocmd vimenter * highlight GitGutterAdd    ctermfg=2 ctermbg=None guibg=NONE
autocmd vimenter * highlight GitGutterChange ctermfg=3 ctermbg=None guibg=NONE
autocmd vimenter * highlight GitGutterDelete ctermfg=1 ctermbg=None guibg=NONE
set signcolumn=yes

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
