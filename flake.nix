{
  description = "System configuration (macOS + NixOS)";

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

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      username = "jesse";
      # Absolute path to the cloned repo — used for out-of-store symlinks so
      # files like CLAUDE.md can be edited without running `just rebuild`.
      # Update this if you clone to a different location.
      mkDotfilesDir = homeDirectory: "${homeDirectory}/dotfiles";

      mkHmConfig = { homeDirectory, hostHome }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "bak";
        home-manager.extraSpecialArgs = { dotfilesDir = mkDotfilesDir homeDirectory; };
        home-manager.users.${username} =
          { lib, ... }:
          {
            imports = [ hostHome ];
            home.username = lib.mkForce username;
            home.homeDirectory = lib.mkForce homeDirectory;
          };
      };
    in
    {
      darwinConfigurations."jmbp" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/jmbp
          home-manager.darwinModules.home-manager
          (mkHmConfig {
            homeDirectory = "/Users/${username}";
            hostHome = ./hosts/jmbp/home.nix;
          })
        ];
      };

      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          (mkHmConfig {
            homeDirectory = "/home/${username}";
            hostHome = ./hosts/nixos/home.nix;
          })
        ];
      };

      nixosConfigurations."orbstack" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/orbstack
          home-manager.nixosModules.home-manager
          (mkHmConfig {
            homeDirectory = "/home/${username}";
            hostHome = ./hosts/orbstack/home.nix;
          })
        ];
      };
    };
}
