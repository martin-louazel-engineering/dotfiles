execute pathogen#infect()

syntax on
filetype plugin indent on
colorscheme desert
hi Search ctermbg=Yellow
hi Search ctermfg=Black
hi VertSplit ctermfg=DarkGrey
hi VertSplit ctermbg=White
let $BASH_ENV = "~/.bash_aliases"
set belloff=all
set formatoptions-=cro
set mouse=nv
set ttymouse=xterm2
set scrolloff=2

let g:airline#extensions#tmuxline#enabled = 0
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='angr'

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

set number
set relativenumber

" indentation
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
"inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" highlight trailing spaces and spaces before a tab
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" line text object
xnoremap il g_o^
onoremap il :normal vil<CR>

" Intelligent tab completion
inoremap <silent> <Tab> <C-r>=<SID>InsertTabWrapper(1)<CR>
inoremap <silent> <S-Tab> <C-r>=<SID>InsertTabWrapper(-1)<CR>
function! <SID>InsertTabWrapper(direction)
  let idx = col('.') - 1
  let str = getline('.')
  if a:direction > 0 && idx >= 2 && str[idx - 1] == ' '
        \&& str[idx - 2] =~? '[a-z]'
    if &softtabstop && idx % &softtabstop == 0
      return "\<BS>\<Tab>\<Tab>"
    else
      return "\<BS>\<Tab>"
    endif
  elseif idx == 0 || str[idx - 1] !~? '[a-z]'
    return "\<Tab>"
  elseif a:direction > 0
    return "\<C-p>"
  else
    return "\<C-n>"
  endif
endfunction

" File explorer
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:NetrwIsOpen=0

function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i 
			endif
			let i-=1
		endwhile
		let g:NetrwIsOpen=0
	else
		let g:NetrwIsOpen=1
		silent Lexplore %:p:h
	endif
endfunction
nnoremap <leader>e :call ToggleNetrw()<CR>

" Git tree
nnoremap <leader>gt :new\|0read !gt

" Copy on system clipboard
set clipboard=unnamedplus
vmap <C-C> y

" Personal tasks
nnoremap <silent> <leader>td :s/\[\s\]/\[x\]<CR>:noh<CR>
nnoremap <silent> <leader>tu :s/\[x\]/\[ \]<CR>:noh<CR>
nnoremap <silent> <leader>tc o[ ]<space>
nnoremap <silent> <leader>ts o<tab>[ ]<space>

" Search related
set ignorecase
set smartcase
set incsearch
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
" Quick diff toggling
nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
	if &diff
		windo diffoff
	else
		windo diffthis
	endif
:endfunction

" Tabs & buffers
set switchbuf+=usetab
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <F5> :source ~/.vimrc<CR>:bufdo e<CR>
set noconfirm " disable confirmation dialog
nnoremap <leader>c :bufdo bd<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>

" Faster file finding
set path+=**
set wildmenu
set wildmode=list:longest,full
set wildignorecase
nnoremap <space>e :tab drop **/
nnoremap <space>f :e **/
nnoremap <space>d :drop **/

" Git grep
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | rightb cw | redraw!
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
nnoremap <leader>gg :Ggr 
nnoremap <leader>[ :Ggr <cword><CR>

" Commenting
map <leader>/ :s/^/\/\/ / <bar> noh<CR>
map <leader>? :s/^\(\t\)\{-\}\/\/ /\1/ <bar> noh<CR>

" folding
set foldmethod=indent
set foldlevelstart=99

" C++ related
nnoremap <leader>m :vimgrep /\v^(\w+\*?\s+)?\w+::\w+\(.*\)/ % \| copen<CR>
" vim-cpp-enhanced-highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Visual Mode start searching
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <leader>[ y:Ggr '<C-R>=escape(@",'/\')<CR>'<CR>

" Git Gutter
set updatetime=500
highlight! link SignColumn LineNr
highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
set signcolumn=yes
