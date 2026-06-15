{ pkgs, ... }: {
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
  ];
}
