if [ "$TMUX" = "" ]; then tmux; fi
fish
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

. "$HOME/.local/bin/env"

# Added by Windsurf
export PATH="/Users/xavierwallis/.codeium/windsurf/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# Added by Antigravity
export PATH="/Users/xavierwallis/.antigravity/antigravity/bin:$PATH"

# OpenClaw Completion
source <(openclaw completion --shell zsh)

# opencode
export PATH=/Users/xavierwallis/.opencode/bin:$PATH

# bun completions
[ -s "/Users/xavierwallis/.bun/_bun" ] && source "/Users/xavierwallis/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
