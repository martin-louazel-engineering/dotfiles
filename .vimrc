execute pathogen#infect()

syntax on
filetype plugin indent on
set tabstop=4
colorscheme desert
hi Search ctermbg=Yellow
hi Search ctermfg=Black

let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='angr'

set number

" Copy on system clipboard
set clipboard=unnamedplus

" Personal tasks
nnoremap <silent> <space>td :s/\[\s\]/\[x\]<CR>
nnoremap <silent> <space>tu :s/\[x\]/\[ \]<CR>
nnoremap <silent> <space>tc o[ ]<space>
nnoremap <silent> <space>ts o<tab>[ ]<space>

" Search related
set ignorecase
set smartcase
nnoremap <silent> * *``
nnoremap <silent> <space><space> :noh<CR>
set hlsearch

" Quicker split creation/navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-\> <C-W>v
set splitright
set splitbelow

" Tabs
nnoremap <C-t> :tabnew<CR>

" Faster file finding
set wildmenu
set wildmode=list:longest,full
set wildignorecase
nnoremap <space>e :tabnew **/
nnoremap <space>f :find **/

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

