{ pkgs, ... }: {
  # Import hardware-configuration.nix after running `nixos-generate-config`
  # on the machine:
  #   imports = [ ./hardware-configuration.nix ];

  networking.hostName = "nixos";

  users.users.jesse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Required so zsh is a recognised login shell
  programs.zsh.enable = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
