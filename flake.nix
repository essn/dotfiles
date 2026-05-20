{
  description = "macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    username = "jesse";
    homeDirectory = "/Users/${username}";
    # Absolute path to the cloned repo — used for out-of-store symlinks so
    # files like CLAUDE.md can be edited without running `just rebuild`.
    # Update this if you clone to a different location.
    dotfilesDir = "${homeDirectory}/code/dots/dotfiles-nix";
  in {
    darwinConfigurations."jmbp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/jmbp
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = { inherit dotfilesDir; };
          home-manager.users.${username} = { lib, ... }: {
            imports = [ ./hosts/jmbp/home.nix ];
            home.username = lib.mkForce username;
            home.homeDirectory = lib.mkForce homeDirectory;
          };
        }
      ];
    };
  };
}
