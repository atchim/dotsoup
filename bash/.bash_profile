if command -v ccache &>/dev/null; then
  export CCACHE_DIR=~/.cache/ccache
  PATH="/usr/lib/ccache/bin:$PATH"
fi

command -v nvim &>/dev/null && export EDITOR=nvim
export MANPATH="$HOME/.local/share/man:$MANPATH"
export SHOT_DIR="$HOME/pix/shot"

command -v opam &>/dev/null && eval "$(opam env)"

command -v cargo &>/dev/null && PATH="$HOME/.cargo/bin:$PATH"
test -d "$HOME/node_modules/.bin" && PATH="$HOME/node_modules/.bin:$PATH"
test -d "$HOME/.surrealdb" && PATH="$HOME/.surrealdb:$PATH"
PATH="$HOME/.local/bin:$PATH"

if command -v pfetch &>/dev/null; then
  export PF_INFO='ascii title os host kernel wm uptime pkgs memory palette'
fi

command -v yarn &>/dev/null && PATH="$HOME/.yarn/bin:$PATH"
