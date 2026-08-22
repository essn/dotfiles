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

    # OrbStack is included in both profiles; PVE is full profile only
    includes =
      lib.optionals pkgs.stdenv.isDarwin [ "~/.orbstack/ssh/config" ]
      ++ lib.optionals (pkgs.stdenv.isDarwin && profile == "full") [
        "~/.ssh/config.d/pve"
        "~/.ssh/config.d/rc-pve"
      ];

    matchBlocks =
      # OrbStack terminal settings for both profiles
      lib.optionalAttrs pkgs.stdenv.isDarwin {
        # xterm-ghostty terminfo isn't present on remote hosts; degrade gracefully
        "orb *.orb".extraOptions.SetEnv = "TERM=xterm-256color";
      }
      // lib.optionalAttrs (pkgs.stdenv.isDarwin && profile == "full") {
        # Use Bitwarden as the SSH agent (full profile only)
        "*".identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
      };
  };
}
