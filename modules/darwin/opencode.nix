{ lib, dotfilesDir, ... }:
{
  # Config for the Homebrew-installed opencode cask.
  # Symlinked out-of-store so edits take effect immediately without
  # running `just rebuild`
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        xdg.configFile = lib.mapAttrs' (name: _: {
          name = "opencode/${name}";
          value.source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/opencode/${name}";
        }) (builtins.readDir ./opencode);
      }
    )
  ];
}
