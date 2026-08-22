{ pkgs, lib, ... }:
{
  home.packages =
    with pkgs;
    [
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
      pkg-config
      arp-scan

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
      ncspot
      cmatrix

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
      sshpass

      # Encryption utilities
      age
      age-plugin-yubikey
      yubikey-manager

      python3
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      # aapt (apktool dependency) only supports x86_64-linux, not aarch64-linux
      apktool

      # Reverse Engineering
      ghidra
      radare2
      dex2jar

      # DSP
      ffmpeg
      sox
    ];
}
