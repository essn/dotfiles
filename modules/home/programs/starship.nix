{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Config managed as a plain TOML file — see starship.toml in this directory
  xdg.configFile."starship.toml".source = ./starship.toml;
}
