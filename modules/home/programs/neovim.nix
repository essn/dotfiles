{
  config,
  lib,
  dotfilesDir,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.neovim ];

  # Out-of-store symlink so edits to nvim/ take effect immediately without rebuilding.
  # Uses home.activation rather than xdg.configFile because home-manager recurses into
  # directory sources and fails its $HOME boundary check on the individual files found.
  # Plain home.packages (not programs.neovim) is used so home-manager doesn't manage
  # ~/.config/nvim itself and clobber the symlink on each rebuild.
  home.activation.nvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    nvim_config="${config.xdg.configHome}/nvim"
    nvim_source="${dotfilesDir}/modules/home/programs/nvim"
    if [ ! -L "$nvim_config" ] || [ "$(readlink "$nvim_config")" != "$nvim_source" ]; then
      $DRY_RUN_CMD rm -rf "$nvim_config"
      $DRY_RUN_CMD ln -sf "$nvim_source" "$nvim_config"
    fi
  '';
}
