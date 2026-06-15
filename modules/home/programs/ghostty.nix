{ pkgs, lib, ... }: lib.mkIf pkgs.stdenv.isDarwin {
  # Ghostty is installed as a cask via modules/darwin/homebrew.nix
  # This module only manages the config file
  xdg.configFile."ghostty/config".text = ''
    # Theme
    theme = Atom One Dark

    # Font — update to your preferred font
    font-size = 13

    # Window
    window-padding-x = 8
    window-padding-y = 8
    macos-titlebar-style = hidden

    # Shell integration
    shell-integration = zsh
  '';
}
