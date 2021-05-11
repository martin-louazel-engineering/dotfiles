execute pathogen#infect()

syntax on
filetype plugin indent on
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
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
function! MoveSeparator(PlusMinus, Vertical)
	let num=tabpagewinnr(tabpagenr())
	let pm=a:PlusMinus
	if  num == "2"
		let pm = pm == '+' ? '-' : '+'
	end
	if a:Vertical
		exec "vertical resize " . pm . "5"
	else
		exec "resize " . pm . "5"
	end
endfunction
nnoremap <silent> <C-S-Down> :call MoveSeparator("+", 0)<CR>
nnoremap <silent> <C-S-Up> :call MoveSeparator("-", 0)<CR>
nnoremap <silent> <C-S-Right> :call MoveSeparator("+", 1)<CR>
nnoremap <silent> <C-S-Left> :call MoveSeparator("-", 1)<CR>

" Tabs
nnoremap <C-t> :tabnew<CR>
set switchbuf+=usetab
nnoremap <leader>t :tabs<CR>
nnoremap <F5> :tabdo e<CR>

" Faster file finding
set wildmenu
set wildmode=list:longest,full
set wildignorecase
nnoremap <space>e :tab drop **/
nnoremap <space>f :find **/
nnoremap <space>d :drop **/

" Git grep
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | rightb cw | redraw!
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
nnoremap <leader>g :Ggr 
nnoremap <leader>p :vs\|Ggr <cword><CR>

" Commenting
map <leader>/ :s/^/\/\/ / <bar> noh<CR>
map <leader>? :s/^\(\t\)\{-\}\/\/ /\1/ <bar> noh<CR>
 
" folding
set foldmethod=indent
set foldlevelstart=99

" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" terminal emulator
tnoremap <Esc> <C-\><C-n>

