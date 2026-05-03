{ config, dotfilesDir, ... }: {
  # Mise — handles dev tool versioning and shell integration
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Symlinked out-of-store so tool versions can be updated without rebuilding
  xdg.configFile."mise/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/home/programs/mise/config.toml";
}
