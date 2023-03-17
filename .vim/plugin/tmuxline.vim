let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W#F',
      \'cwin' : '#I #W#F',
      \'x'    : ['%a %d-%m-%Y', '%R'],
      \'y'    : '#H #{tmux_mode_indicator}',
	  \'options' : {'status-justify' : 'left'}
	  \}
