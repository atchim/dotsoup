status --is-interactive; or exit

# Colors
set fish_color_autosuggestion white
set fish_color_cancel --bold --reverse brred
set fish_color_command --bold magenta
set fish_color_comment white
set fish_color_cwd brcyan
set fish_color_cwd_root brred
set fish_color_end brcyan
set fish_color_error --bold brred
set fish_color_escape --bold --reverse brcyan
set fish_color_history_current --bold brwhite
set fish_color_host --bold brmagenta
set fish_color_host_remote --bold magenta
set fish_color_match --background=brblack --bold
set fish_color_normal normal
set fish_color_operator brcyan
set fish_color_param brblue
set fish_color_quote brgreen
set fish_color_redirection yellow
set fish_color_search_match --reverse
set fish_color_selection --background=brblack
set fish_color_status brred
set fish_color_user brblue
set fish_color_valid_path --underline
set fish_pager_color_completion brwhite
set fish_pager_color_description brgreen
set fish_pager_color_prefix white
set fish_pager_color_progress --reverse

# Cursor
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace underscore
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# fff
type -q fff
and function f -d 'fff with cd on exit'
  fff $argv
  set -q XDG_CACHE_HOME
  and set -l cache_dir $XDG_CACHE_HOME
  or set -l cache_dir ~/.cache
  pushd (cat $cache_dir/fff/.fff_d)
end

function fish_greeting; end
function fish_user_key_bindings; fish_vi_key_bindings; end
type -q starship; and starship init fish | source
