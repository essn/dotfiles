# Rebuild macOS system configuration
rebuild:
    darwin-rebuild switch --flake .#jmbp

# Update all flake inputs
update:
    nix flake update

# Update a specific flake input
update-input input:
    nix flake update {{input}}

# Build without switching (useful for checking before applying)
build:
    darwin-rebuild build --flake .#jmbp

# Show diff between current and new config
diff: build
    nix store diff-closures /run/current-system ./result

# Garbage collect old generations
gc:
    nix-collect-garbage -d
    nix store optimise
    mise prune

# Check flake for errors
check:
    nix flake check
