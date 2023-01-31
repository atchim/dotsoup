# Ccache
command -v ccache &>/dev/null && export CCACHE_DIR=~/.cache/ccache
command -v ccache &>/dev/null && PATH="/usr/lib/ccache/bin:$PATH"

# fff
if command -v fff &>/dev/null; then
  export FFF_COL2=5
  export FFF_COL3=3
  export FFF_COL4=5
  export FFF_FAV1=~
  export FFF_FAV2=~/repo
  export FFF_FAV3=~/lab
  export FFF_FAV4=~/dl
  export FFF_MARK_FORMAT=[%f]
fi

# PATH
command -v cargo &>/dev/null && PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

# Vars
command -v nvim &>/dev/null && export EDITOR=nvim
export MANPATH="$HOME/.local/share/man:$MANPATH"
export SHOT_DIR="$HOME/pix/shot"

# pfetch
if command -v pfetch &>/dev/null; then
  export PF_INFO='ascii title os host kernel wm uptime pkgs memory palette'
fi
