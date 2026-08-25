{ pkgs, ... }:
{
  # Build essentials for Mise to compile language runtimes from source.
  # Mirrors the Homebrew brews in modules/darwin/homebrew.nix, which serve
  # the same purpose on macOS via /opt/homebrew/opt/.
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    pkg-config
    cmake
    openssl
    zlib
    bzip2
    readline
    sqlite
    ncurses
    xz
    tcl
    libxml2
    libffi
    python3
    (writeShellScriptBin "python" ''exec ${python3}/bin/python3 "$@"'')
  ];

  # Allow pre-built binaries (Rust, Bun, JDK, etc.) to run on NixOS.
  # These binaries hardcode /lib/ld-linux-*.so.* which doesn't exist here;
  # nix-ld provides a shim at that path pointing into the Nix store.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      openssl
      zlib
    ];
  };
}
