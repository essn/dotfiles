{ config, pkgs, ... }:
let
  home = "/Users/${config.system.primaryUser}";
in
{
  # Local npm registry, started at login via a launchd user agent.
  # Verdaccio itself is installed by mise (npm:verdaccio), so run it through
  # `mise x` to get the right node on PATH.
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
}
