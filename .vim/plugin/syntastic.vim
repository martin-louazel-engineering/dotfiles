" Eslint configuration
let g:syntastic_javascript_checkers=['eslint']
" Use project-specific version of eslint
let g:syntastic_javascript_eslint_exe='[ -f $(npm bin)/eslint ] && $(npm bin)/eslint || eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
let g:syntastic_python_checkers=['python']
let g:syntastic_python_python_quiet_messages={'!level':'errors'}
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>

let g:syntastic_cpp_checkers=['cppcheck']
let g:syntastic_cpp_check_header = 1
