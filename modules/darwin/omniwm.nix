{
  lib,
  pkgs,
  dotfilesDir,
  ...
}:
{
  environment.systemPackages = [ pkgs.omniwm ];

  # OmniWM settings are symlinked out-of-store so edits take effect
  # immediately (OmniWM live-reloads settings.toml) without `just rebuild`.
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        xdg.configFile = lib.mapAttrs' (name: _: {
          name = "omniwm/${name}";
          value.source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/omniwm/${name}";
        }) (builtins.readDir ./omniwm);
      }
    )
  ];
}
