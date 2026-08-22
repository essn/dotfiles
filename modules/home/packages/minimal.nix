{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core utilities
    wget
    curl
    unzip
    tree
    jq
    shellcheck
    git-extras
    socat
    pkg-config

    # Nix utils
    statix
    nixfmt-rfc-style

    # Modern CLI replacements (used by shell aliases)
    ripgrep
    fd
    bat
    eza

    # Text & data viewers
    glow # markdown viewer
    tealdeer # tldr client

    # System monitoring & disk tools
    dust # dust — du replacement
    procs # ps replacement
    bottom # btm — system monitor
    duf # df replacement

    # Git extras
    git-lfs
    lazygit
    delta
    gh

    # Developer tools
    just
    watchexec

    # Secrets
    rbw
    pinentry-curses

    python3
  ];
}
