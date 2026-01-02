# Modern tool initializations

# Zoxide - smarter cd command
if command -q zoxide
    zoxide init fish | source
end

# fzf - fuzzy finder
if command -q fzf
    # Key bindings (Ctrl+R for history, Ctrl+T for files, Alt+C for cd)
    # NOTE: Atuin takes Ctrl+R
    fzf --fish | source

    # Use fd for fzf if available
    if command -q fd
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    end

    # Use bat for preview if available
    if command -q bat
        set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
    end
end

# Direnv - auto-load environment variables
if command -q direnv
    direnv hook fish | source
end

# Mise - tool frontend
if command -q mise
    mise activate fish | source
    mise completions fish | source
end

# Atuin - magical shell history
if command -q atuin
    atuin init fish | source
    atuin gen-completion --shell fish | source
end

# Chezmoi - dotfiles management
if command -q chezmoi
    chezmoi completion fish | source
end

# Exercism - coding exercises
if command -q exercism
    exercism completion fish | source
end

# Just - command runner
if command -q just
    just --completions fish | source
end
