{ pkgs, ... }:
{
  imports = [
    ../../modules/nixos/packages.nix
    # Add hardware-configuration.nix after running `nixos-generate-config`:
    #   ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  users.users.jesse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # Required so zsh is a recognised login shell
  programs.zsh.enable = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.11";
}
