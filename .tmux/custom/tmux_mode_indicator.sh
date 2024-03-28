# Requires https://github.com/MunifTanjim/tmux-mode-indicator

show_tmux_mode_indicator() { # This function name must match the module name!
  local index icon color text module

  index=$1 # This variable is used internally by the module loader in order to know the position of this module

  icon="$(  get_tmux_option "@catppuccin_tmux_mode_indicator_icon"  ""           )"
  color="$( get_tmux_option "@catppuccin_tmux_mode_indicator_color" "$thm_orange" )"
  text="$(  get_tmux_option "@catppuccin_tmux_mode_indicator_text"  "#{tmux_mode_indicator}" )"

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
