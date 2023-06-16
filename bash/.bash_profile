##########
# Ccache #
##########

if command -v ccache &>/dev/null; then
  export CCACHE_DIR=~/.cache/ccache
  PATH="/usr/lib/ccache/bin:$PATH"
fi

#######
# fff #
#######

if command -v fff &>/dev/null; then
  export FFF_COL2=5
  export FFF_COL3=3
  export FFF_COL4=5
  export FFF_FAV1=~
  export FFF_FAV2=~/repo
  export FFF_FAV3=~/lab
  export FFF_FAV4=~/dl
  export FFF_MARK_FORMAT='[%f]'
fi

########
# opam #
########

command -v opam &>/dev/null && eval $(opam env)

########
# PATH #
########

command -v cargo &>/dev/null && PATH="$HOME/.cargo/bin:$PATH"
test -d "$HOME/node_modules/.bin" && PATH="$HOME/node_modules/.bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

##########
# pfetch #
##########

if command -v pfetch &>/dev/null; then
  export PF_INFO='ascii title os host kernel wm uptime pkgs memory palette'
fi

#########################
# Environment Variables #
#########################

command -v nvim &>/dev/null && export EDITOR=nvim
export MANPATH="$HOME/.local/share/man:$MANPATH"
export SHOT_DIR="$HOME/pix/shot"
