# dotfiles

System configuration for macOS (nix-darwin) and NixOS, with home-manager for the user environment.

## Bootstrap

### macOS

Install Nix and Homebrew if not already present:
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Clone and run the first-time switch (`darwin-rebuild` doesn't exist yet on a fresh machine):
```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
sudo nix run nix-darwin -- switch --flake .#jmbp
```

After the first run, use `just rebuild` for all subsequent applies.

### NixOS

Clone the repo, add your generated hardware config, then switch:
```bash
git clone <repo-url> ~/dotfiles
nixos-generate-config --show-hardware-config > ~/dotfiles/hosts/nixos/hardware-configuration.nix
cd ~/dotfiles
nixos-rebuild switch --flake .#nixos
```

Add `hardware-configuration.nix` to the `imports` list in `hosts/nixos/default.nix`, then commit it. After the first switch, `just rebuild-nixos` works.

## Personal config (not tracked)

Create `~/.config/git/local` with your identity:
```
[user]
    name  = Your Name
    email = you@example.com
    signingkey = ssh-ed25519 AAAA...
```

## Daily use

| Command | Description |
|---|---|
| `just rebuild` | Apply config changes (macOS) |
| `just rebuild-nixos` | Apply config changes (NixOS) |
| `just diff` | Preview what would change (macOS) |
| `just diff-nixos` | Preview what would change (NixOS) |
| `just update` | Update all flake inputs |
| `just update-input <input>` | Update a single flake input |
| `just check` | Validate the flake |
| `just gc` | Collect old generations and optimise the store |

## Adding a host

**macOS:**
1. Create `hosts/<hostname>/default.nix` and `home.nix` (copy from `hosts/jmbp` as a starting point)
2. Add a `darwinConfigurations."<hostname>"` entry to `flake.nix` using `mkHmConfig`
3. Bootstrap on the new machine: `sudo nix run nix-darwin -- switch --flake .#<hostname>`

**NixOS:**
1. Create `hosts/<hostname>/default.nix` and `home.nix` (copy from `hosts/nixos` as a starting point)
2. Add a `nixosConfigurations."<hostname>"` entry to `flake.nix` using `mkHmConfig`
3. Generate and commit `hardware-configuration.nix` for the machine
4. Bootstrap: `nixos-rebuild switch --flake .#<hostname>`
