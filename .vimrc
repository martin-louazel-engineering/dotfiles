let $BASH_ENV = "~/.bash_aliases"
set belloff=all
set formatoptions-=cro
set mouse=nv
if !has('nvim')
	set ttymouse=xterm2
endif
set scrolloff=2

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin('~/.vim/plugged')

Plug 'sainnhe/sonokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'martin-louazel-engineering/vim-tmux-navigator'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'jpalardy/vim-slime'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'vim-syntastic/syntastic'

Plug 'solarnz/thrift.vim'

call plug#end()
syntax on
filetype plugin indent on

colorscheme sonokai
autocmd vimenter * highlight Normal ctermbg=NONE
autocmd vimenter * highlight EndOfBuffer ctermbg=NONE

set number
set relativenumber
set cursorline

" ctags
command! -nargs=* MakeTags !ctags -R <q-args>
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

" spare the shift keystroke in normal mode
nnoremap ; :

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

nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gt :GT <cword><CR>
" Add hyphen to keywords to make it easier to <cword> branch names
autocmd FileType git setlocal iskeyword+=-
autocmd FileType git set nowrap

let g:gtColumn = 1
function! GtSearch(increment)
	if a:increment
		let g:gtColumn += 2
	else
		let g:gtColumn -= 2
	end
	let @/ = "\\%" . g:gtColumn . "c[*|]"
	normal n
endfunction

nnoremap ]g :call GtSearch(1)<CR>
nnoremap [g :call GtSearch(0)<CR>

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
nnoremap <silent> * *N
nnoremap <silent> <space><space> :noh<CR>
set hlsearch

set splitright
set splitbelow
" Quick wrap toggle
nnoremap <leader>tw :call WrapToggle()<CR>
function! WrapToggle()
	if &wrap
		windo set nowrap
	else
		windo set wrap
	endif
:endfunction

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
set wildmenu
set wildmode=list:longest,full
set wildignorecase
nnoremap <space>f :FZF<CR>
nnoremap <leader>f :GFiles<CR>

" Git grep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --glob "!tags" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | rightb cw | redraw!
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
nnoremap <leader>gg :Ggr <cword><CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>[ :Rg <C-R><C-W><CR>
vnoremap <leader>[ y:Rg <C-R>=escape(@",'/\')<CR><CR>

" Commenting
map <leader>/ :s/^/\/\/ / <bar> noh<CR>
map <leader>? :s/^\(\t\)\{-\}\/\/ /\1/ <bar> noh<CR>

" folding
set foldmethod=indent
" Avoid folding when opening a file
set foldlevelstart=99

" C++ related
" Find all class members in cpp file and open in quickfix window
autocmd FileType cpp nnoremap <leader>m :vimgrep /\v^(\w+\*?\s+)?\w+::\w+\(.*\)/ % \| copen<CR>

" Visual Mode start searching
function! VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  " Use this line instead of the above to match matches spanning across lines
  "let @/ = '\V' . substitute(escape(@@, '\'), '\_s\+', '\\_s\\+', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction

vnoremap * :<C-u>call VSetSearch()<CR>/<CR>N
vnoremap # :<C-u>call VSetSearch()<CR>?<CR>N

" Hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    "silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
command! -bar Hexmode call ToggleHex()
nnoremap <leader>hx :Hexmode<CR>

command! -nargs=1 -complete=highlight Unmatch
    \  for m in filter(getmatches(), { i, v -> l:v.group is? <q-args> })
    \|     call matchdelete(m.id)
    \| endfor
