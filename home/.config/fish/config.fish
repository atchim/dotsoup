status --is-interactive
or exit

#
# Colors
#

set fish_color_autosuggestion white
set fish_color_cancel --background=black --bold brred
set fish_color_command --bold magenta
set fish_color_comment white
set fish_color_end brcyan
set fish_color_error --bold brred
set fish_color_escape brcyan
set fish_color_history_current --bold brwhite
set fish_color_match --background=brblack
set fish_color_normal normal
set fish_color_operator brcyan
set fish_color_param brblue
set fish_color_quote brgreen
set fish_color_redirection brcyan
set fish_color_search_match --background=brblack
set fish_color_selection --background=brblack
set fish_color_status brred
set fish_color_valid_path --underline brwhite
set fish_pager_color_completion brwhite
set fish_pager_color_description brgreen
set fish_pager_color_prefix white
set fish_pager_color_progress --background=brblack --bold brwhite

#
# Cursor
#

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace underscore
set fish_cursor_replace_one underscore
set fish_cursor_visual block

#
# Functions
#

function f -d 'fff with cd on exit'
  fff $argv
  set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME $HOME/.cache
  pushd (cat $XDG_CACHE_HOME/fff/.fff_d)
end

#
# Fancy Stuff
#

function fish_greeting; fortune | cowsay; end
function fish_user_key_bindings; fish_vi_key_bindings; end
starship init fish | source
