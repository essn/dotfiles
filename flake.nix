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
      # Absolute path to the cloned repo — used for out-of-store symlinks so
      # files like CLAUDE.md can be edited without running `just rebuild`.
      # Update this if you clone to a different location.
      mkDotfilesDir = homeDirectory: "${homeDirectory}/dotfiles";

      mkHmConfig =
        {
          username,
          homeDirectory,
          hostHome,
          profile ? "full",
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = {
            dotfilesDir = mkDotfilesDir homeDirectory;
            inherit profile;
          };
          home-manager.users.${username} =
            { lib, ... }:
            {
              imports = [ hostHome ];
              home.username = lib.mkForce username;
              home.homeDirectory = lib.mkForce homeDirectory;
            };
        };

      # Standalone home-manager config for non-NixOS hosts (Nix installed on
      # top of another distro) — no system-level module to manage.
      mkStandaloneHome =
        {
          system,
          username,
          homeDirectory,
          hostHome,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            dotfilesDir = mkDotfilesDir homeDirectory;
          };
          modules = [
            hostHome
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ];
        };
    in
    {
      darwinConfigurations."jmbp" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          profile = "full";
        };
        modules = [
          ./hosts/jmbp
          home-manager.darwinModules.home-manager
          (mkHmConfig {
            username = "jesse";
            homeDirectory = "/Users/jesse";
            hostHome = ./hosts/jmbp/home.nix;
            profile = "full";
          })
        ];
      };

      darwinConfigurations."darwin-devbx" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          profile = "minimal";
        };
        modules = [
          ./hosts/darwin-devbx
          home-manager.darwinModules.home-manager
          (mkHmConfig {
            username = "darwin-devbx";
            homeDirectory = "/Users/darwin-devbx";
            hostHome = ./hosts/darwin-devbx/home.nix;
            profile = "minimal";
          })
        ];
      };

      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          (mkHmConfig {
            username = "jesse";
            homeDirectory = "/home/jesse";
            hostHome = ./hosts/nixos/home.nix;
            profile = "full";
          })
        ];
      };

      nixosConfigurations."orbstack" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/orbstack
          home-manager.nixosModules.home-manager
          (mkHmConfig {
            username = "jesse";
            homeDirectory = "/home/jesse";
            hostHome = ./hosts/orbstack/home.nix;
            profile = "full";
          })
        ];
      };

      homeConfigurations."jumpbox" = mkStandaloneHome {
        system = "x86_64-linux";
        username = "jumpbox";
        homeDirectory = "/home/jumpbox";
        hostHome = ./hosts/jumpbox/home.nix;
      };
    };
}
