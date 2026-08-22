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

    # Full profile only: OrbStack, PVE configs, and Bitwarden SSH agent
    includes = lib.optionals (pkgs.stdenv.isDarwin && profile == "full") [
      "~/.orbstack/ssh/config"
      "~/.ssh/config.d/pve"
      "~/.ssh/config.d/rc-pve"
    ];

    matchBlocks = lib.optionalAttrs (pkgs.stdenv.isDarwin && profile == "full") {
      # xterm-ghostty terminfo isn't present on remote hosts; degrade gracefully
      "orb *.orb".extraOptions.SetEnv = "TERM=xterm-256color";
      # Use Bitwarden as the SSH agent
      "*".identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    };
  };
}
