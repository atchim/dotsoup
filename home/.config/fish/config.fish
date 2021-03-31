status --is-interactive
or exit

#
# Login
#

if status --is-login
  set -e PATH

  set -a PATH /sbin
  set -a PATH /bin
  set -a PATH /opt/bin
  set -a PATH /usr/sbin
  set -a PATH /usr/bin
  set -a PATH /usr/local/sbin
  set -a PATH /usr/local/bin

  set -p PATH /usr/lib/ccache/bin
  set -p PATH /usr/lib/llvm/11/bin

  set -e fish_user_paths
  set -a fish_user_paths ~/.bin
  set -a fish_user_paths ~/.cargo/bin
  set -a fish_user_paths ~/.go/bin
  set -a fish_user_paths ~/.local/bin
end

#
# Environment Variables
#

set -gx _JAVA_AWT_WM_NONREPARENTING 1
set -gx CCACHE_DIR /var/cache/ccache
set -gx EDITOR nvim
set -gx GOPATH ~/.go
set -gx SCREENSHOT_DIR ~/img/shot
set -gx SUMNEKO_LUA_DIR ~/repo/lua-language-server

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
