#
# Exports
#

# fff
export FFF_COL2=5
export FFF_COL3=3
export FFF_COL4=5
export FFF_FAV1=~
export FFF_FAV2=~/repo
export FFF_FAV3=~/lab
export FFF_FAV4=~/dl
export FFF_MARK_FORMAT=[%f]

# Misc
export CCACHE_DIR="$HOME/.cache/ccache"
export EDITOR=nvim
export MANPATH="$HOME/.local/share/man:$MANPATH"
export PF_INFO='ascii title os host kernel wm uptime pkgs memory palette'
export SHELL=/bin/fish

#
# PATH
#

usr_path=(
  ~/.cargo/bin
  ~/.local/bin
  /usr/lib/ccache/bin
)

for path in "${usr_path[@]}"; do
  PATH="$path:$PATH"
done

export PATH
