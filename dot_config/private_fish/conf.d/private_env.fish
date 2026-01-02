# Environment variables

# Editor configuration
if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else if command -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
else
    set -gx EDITOR nano
    set -gx VISUAL nano
end

# Pager
if command -q less
    set -gx PAGER less
    set -gx LESS '-R -F -X'
end

# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.cache
set -gx XDG_STATE_HOME ~/.local/state

# Enable color support
set -gx CLICOLOR 1
