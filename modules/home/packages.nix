{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core utilities
    wget
    curl
    unzip
    tree
    nmap
    jq
    shellcheck
    hyperfine
    git-extras
    doggo
    socat

    # Nix utils
    statix
    nixfmt

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

    # Infrastructure
    kubectl
    kubernetes-helm
    cilium-cli
    k9s
    opentofu
    terraform-ls
    ansible
    helmfile
    kubectx
    kubeseal

    # Developer tools
    just
    watchexec

    # Secrets
    rbw
    pinentry-curses

    # Reverse Engineering
    ghidra
    radare2
    apktool
    dex2jar

    # Encryption utilities
    age
    age-plugin-yubikey
    yubikey-manager
  ];
}
