status --is-interactive
or exit

if status --is-login; ~/.local/bin/envsoup fish | source; end

#
# Colors
#

set fish_color_autosuggestion white
set fish_color_cancel --background=black --bold red
set fish_color_command --bold magenta
set fish_color_comment white
set fish_color_end cyan
set fish_color_error --bold red
set fish_color_escape cyan
set fish_color_history_current --bold brwhite
set fish_color_match --background=brblack
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param blue
set fish_color_quote green
set fish_color_redirection cyan
set fish_color_search_match --background=brblack
set fish_color_selection --background=brblack
set fish_color_status red
set fish_color_valid_path --underline brwhite
set fish_pager_color_completion brwhite
set fish_pager_color_description green
set fish_pager_color_prefix white
set fish_pager_color_progress --background=brblack --bold brwhite

#
# Fancy Stuff
#

set fish_greeting
starship init fish | source
