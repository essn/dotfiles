{ ... }:
{
  imports = [
    ../../modules/darwin
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Required when using the Determinate Systems Nix installer
  nix.enable = false;

  # Required for user-specific system.defaults and homebrew options
  system.primaryUser = "darwin-devbx";

  system.stateVersion = 5;
}
