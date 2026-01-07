# Main fish configuration

# Disable greeting
set -g fish_greeting

# History settings
set -g fish_history_max_lines 10000
set -g fish_history_ignore_duplicates true

# Path management - add common local bin directories if they exist
fish_add_path -gP ~/.local/bin
fish_add_path -gP ~/bin
fish_add_path -gP ~/.cargo/bin

# Enable vi key bindings (comment out if you prefer default emacs mode)
fish_vi_key_bindings

if status is-interactive
    # Commands to run in interactive sessions can go here
end
