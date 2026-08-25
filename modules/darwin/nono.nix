{ lib, dotfilesDir, ... }:
{
  # Profiles for the Homebrew-installed nono cask.
  # Symlinked out-of-store so edits take effect immediately without
  # running `just rebuild`
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        xdg.configFile = lib.mapAttrs' (name: _: {
          name = "nono/profiles/${name}";
          value.source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/nono/${name}";
        }) (builtins.readDir ./nono);
      }
    )
  ];
}
