{ ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Include OrbStack's auto-generated host config — must be first
    includes = [ "~/.orbstack/ssh/config" ];

    # Use Bitwarden as the SSH agent for all connections
    matchBlocks."*" = {
      identityAgent = "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    };
  };
}
