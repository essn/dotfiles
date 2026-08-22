# Rebuild macOS system configuration
rebuild:
    darwin-rebuild switch --flake .#jmbp

# Rebuild darwin-devbx system configuration (run on the devbx VM)
rebuild-devbx:
    darwin-rebuild switch --flake .#darwin-devbx

# Rebuild NixOS configuration (run on the nixos host)
rebuild-nixos:
    nixos-rebuild switch --flake .#nixos

# First-time jumpbox setup — home-manager isn't installed yet, so run it
# straight from the flake input (run on the jumpbox host)
bootstrap-jumpbox:
    NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager/master -- switch --flake .#jumpbox

# Rebuild jumpbox home-manager config, once bootstrapped (run on the jumpbox host)
rebuild-jumpbox:
    NIX_CONFIG="experimental-features = nix-command flakes" home-manager switch --flake .#jumpbox

# Update all flake inputs
update:
    nix flake update

# Update a specific flake input
update-input input:
    nix flake update {{input}}

# Build without switching (useful for checking before applying)
build:
    darwin-rebuild build --flake .#jmbp

# Build darwin-devbx without switching
build-devbx:
    darwin-rebuild build --flake .#darwin-devbx

# Build NixOS config without switching (run on the nixos host)
build-nixos:
    nixos-rebuild build --flake .#nixos

# Build jumpbox home-manager config without switching (run on the jumpbox host)
build-jumpbox:
    NIX_CONFIG="experimental-features = nix-command flakes" home-manager build --flake .#jumpbox

# Show diff between current and new config
diff: build
    nix store diff-closures /run/current-system ./result

# Show diff for darwin-devbx config
diff-devbx: build-devbx
    nix store diff-closures /run/current-system ./result

# Show diff for NixOS config (run on the nixos host)
diff-nixos: build-nixos
    nix store diff-closures /run/current-system ./result

# Garbage collect old generations
gc:
    nix-collect-garbage -d
    nix store optimise
    mise prune

# Check flake for errors
check:
    nix flake check

# Scan the whole Nix store for corruption (re-hashes file contents — can be slow)
nix-check:
    nix-store --verify --check-contents

# Verify and repair any corrupted, substitutable store paths
[confirm("This will sudo-repair the Nix store. Continue?")]
nix-repair:
    sudo nix-store --verify --check-contents --repair

# Repair a single store path by re-realising it: `just nix-repair-path /nix/store/...`
nix-repair-path path:
    sudo nix-store --realise --repair {{path}}

# macOS: First Aid on the dedicated Nix Store APFS volume
[macos]
nix-disk-check:
    diskutil verifyVolume "Nix Store"
