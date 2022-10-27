syntax on
filetype plugin indent on
hi VertSplit ctermfg=DarkGrey
hi VertSplit ctermbg=White
let $BASH_ENV = "~/.bash_aliases"
set belloff=all
set formatoptions-=cro
set mouse=nv
if !has('nvim')
	set ttymouse=xterm2
endif
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
Plugin 'sainnhe/sonokai'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'edkolev/tmuxline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'martin-louazel-engineering/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-surround'
Plugin 'jpalardy/vim-slime'

Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-syntastic/syntastic'

call vundle#end()

colorscheme sonokai
autocmd vimenter * highlight Normal ctermbg=NONE
autocmd vimenter * highlight EndOfBuffer ctermbg=NONE

set number
set relativenumber

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

" Git tree
nnoremap <leader>gc :Git checkout <cword><CR>
nnoremap <leader>gp :Git cherry-pick <cword><CR>
nnoremap <leader>gb :Git blame<CR>
command! -nargs=* -complete=customlist,fugitive#Complete GT Git ++curwin --paginate log --decorate --graph --oneline <args>
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
nnoremap <silent> * *``
nnoremap <silent> <space><space> :noh<CR>
set hlsearch

set splitright
set splitbelow
let g:tmux_navigator_resize_step=3
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

" Git grep
command! -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | rightb cw | redraw!
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
nnoremap <leader>gg :Ggr<space>
nnoremap <leader>[ :Ggr <cword><CR>

" Commenting
map <leader>/ :s/^/\/\/ / <bar> noh<CR>
map <leader>? :s/^\(\t\)\{-\}\/\/ /\1/ <bar> noh<CR>

" folding
set foldmethod=indent
" Avoid folding when opening a file
set foldlevelstart=99

" C++ related
" Find all class members in cpp file and open in quickfix window
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
autocmd vimenter * highlight! link SignColumn LineNr
autocmd vimenter * highlight GitGutterAdd    ctermfg=2 ctermbg=None
autocmd vimenter * highlight GitGutterChange ctermfg=3 ctermbg=None
autocmd vimenter * highlight GitGutterDelete ctermfg=1 ctermbg=None
set signcolumn=yes

" Eslint configuration
let g:syntastic_javascript_checkers=['eslint']
" Use project-specific version of eslint
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>

" Hex mode
function ToggleHex()
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
command -bar Hexmode call ToggleHex()
nnoremap <leader>hx :Hexmode<CR>

"vim-slime configuration for tmux
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
