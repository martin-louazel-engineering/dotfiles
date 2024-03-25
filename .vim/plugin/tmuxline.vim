let g:tmuxline_preset = {
      \'b'    : '#{tmux_mode_style} #S #[default]',
      \'win'  : '#I #W#F',
      \'cwin' : '#I #W#F',
      \'x'    : ['%R'],
      \'y'    : ' #H #{tmux_mode_indicator}',
	  \'options' : {'status-justify' : 'left'}
	  \}

let g:tmuxline_separators = {
    \ 'left' : ' ',
    \ 'left_alt': ' ',
    \ 'right' : ' ',
    \ 'right_alt' : ' ' ,
    \ 'space' : ' '}
