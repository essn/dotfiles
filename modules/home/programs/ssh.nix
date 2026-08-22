{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # OrbStack and PVE includes are macOS-only
    includes = lib.optionals pkgs.stdenv.isDarwin [
      "~/.orbstack/ssh/config"
      "~/.ssh/config.d/pve"
      "~/.ssh/config.d/rc-pve"
    ];

    # Use Bitwarden as the SSH agent for all connections (macOS only)
    matchBlocks = lib.optionalAttrs pkgs.stdenv.isDarwin {
      "*".identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
      # xterm-ghostty terminfo isn't present on remote hosts; degrade gracefully
      "orb *.orb".extraOptions.SetEnv = "TERM=xterm-256color";
    };
  };
}
