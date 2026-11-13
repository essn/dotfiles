{
  config,
  pkgs,
  dotfilesDir,
  ...
}:
let
  home = "/Users/${config.system.primaryUser}";
in
{
  # Local npm registry, started at login via a launchd user agent.
  # Verdaccio itself is installed by mise (npm:verdaccio), so run it through
  # `mise x` to get the right node on PATH. Mise installs npm packages via
  # this registry, so on a fresh machine run `just bootstrap-verdaccio` first.
  # Config is generated on first run at ~/.config/verdaccio/config.yaml.
  launchd.user.agents.verdaccio = {
    command = "${pkgs.mise}/bin/mise x -- verdaccio --listen 127.0.0.1:4873";
    serviceConfig = {
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      WorkingDirectory = home;
      EnvironmentVariables = {
        HOME = home;
        PATH = "/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin";
      };
      StandardOutPath = "${home}/Library/Logs/verdaccio.log";
      StandardErrorPath = "${home}/Library/Logs/verdaccio.log";
    };
  };

  # Point npm and bun at the local registry. Symlinked out-of-store so edits
  # take effect immediately without `just rebuild`.
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        home.file.".npmrc".source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/verdaccio/npmrc";
        home.file.".bunfig.toml".source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/verdaccio/bunfig.toml";
      }
    )
  ];
}
