{
  pkgs,
  lib,
  profile ? "full",
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # OrbStack and PVE includes are macOS full profile only
    includes = lib.optionals (pkgs.stdenv.isDarwin && profile == "full") [
      "~/.orbstack/ssh/config"
      "~/.ssh/config.d/pve"
      "~/.ssh/config.d/rc-pve"
    ];

    # Use Bitwarden as the SSH agent for full profile, standard agent for minimal
    matchBlocks = lib.optionalAttrs (pkgs.stdenv.isDarwin && profile == "full") {
      "*".identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
      # xterm-ghostty terminfo isn't present on remote hosts; degrade gracefully
      "orb *.orb".extraOptions.SetEnv = "TERM=xterm-256color";
    };
  };
}
