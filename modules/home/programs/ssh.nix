{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # OrbStack and PVE includes are macOS-only
    includes = lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      "~/.orbstack/ssh/config"
      "~/.ssh/config.d/pve"
      "~/.ssh/config.d/rc-pve"
    ];

    # Use Bitwarden as the SSH agent for all connections (macOS only)
    settings = lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      "*".identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
      # xterm-ghostty terminfo isn't present on remote hosts; degrade gracefully
      "orb *.orb".setEnv = {
        TERM = "xterm-256color";
      };
    };
  };
}
