{ pkgs, ... }: {
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

    # Modern CLI replacements (used by shell aliases)
    ripgrep
    fd
    bat
    eza

    # Text & data viewers
    glow        # markdown viewer
    tealdeer    # tldr client

    # System monitoring & disk tools
    dust     # dust — du replacement
    procs       # ps replacement
    bottom      # btm — system monitor
    duf         # df replacement

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
    ansible

    # Developer tools
    just
    watchexec

    # Secrets
    rbw
  ];
}
