#
# Exports
#

export CCACHE_DIR="$HOME/.cache/ccache"
export EDITOR=nvim
export GHCUP_INSTALL_BASE_PREFIX="$HOME"
export GOPATH="$HOME/.go"
export MANPATH="$HOME/.local/share/man:$MANPATH"
export PF_INFO='ascii title os host kernel wm uptime pkgs memory palette'
export SHELL=/bin/fish

#
# PATH
#

usr_path=(
  ~/.cabal/bin
  ~/.cargo/bin
  ~/.ghcup/bin
  ~/.go/bin
  ~/.luarocks/bin
  ~/.local/bin
  /usr/lib/ccache/bin
)

for path in "${usr_path[@]}"; do
  PATH="$path:$PATH"
done

export PATH
