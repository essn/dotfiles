# dotfiles-nix

macOS system configuration managed with [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Prerequisites

- **Nix** — install via the [Determinate Systems installer](https://github.com/DeterminateSystems/nix-installer):
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- **Homebrew** — must be installed separately; nix-darwin manages casks but not the Homebrew installation itself:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **just** — task runner used in place of make:
  ```bash
  brew install just
  ```

## First-time setup

**1. Clone the repo:**
```bash
git clone <repo-url> ~/dotfiles-nix
cd ~/dotfiles-nix
```

**2. Copy your Neovim config** (home-manager symlinks this directory):
```bash
cp -r ~/.config/nvim modules/home/programs/nvim
```

**3. Create your git local config** (keeps name, email, and signing key out of the repo):
```bash
mkdir -p ~/.config/git
cat > ~/.config/git/local <<EOF
[user]
    name = Your Name
    email = you@example.com
    signingkey = ssh-ed25519 AAAA...
EOF
```

**4. Bootstrap nix-darwin** (first run only — `darwin-rebuild` doesn't exist yet):
```bash
sudo nix run nix-darwin -- switch --flake .#jmbp
```

After the first run, use `just rebuild` for all subsequent applies.

## Usage

| Command | Description |
|---|---|
| `just rebuild` | Apply configuration changes |
| `just build` | Build without switching (dry run) |
| `just diff` | Show what would change before applying |
| `just update` | Update all flake inputs to latest |
| `just update-input nixpkgs` | Update a single flake input |
| `just check` | Validate the flake for errors |
| `just gc` | Garbage collect old generations |

## Structure

```
hosts/
└── jmbp/
    ├── default.nix     # Host-specific nix-darwin config (platform, primaryUser)
    └── home.nix        # Host-specific home-manager entry point

modules/
├── claude/
│   ├── default.nix     # Symlinks ~/.claude/CLAUDE.md out-of-store for live edits
│   └── CLAUDE.md       # Global Claude.ai preferences
├── darwin/
│   ├── default.nix           # Imports all darwin modules
│   ├── system-defaults.nix   # macOS preferences (key repeat, Finder, Dock, etc.)
│   └── homebrew.nix          # Build essentials + GUI apps via Homebrew casks
└── home/
    ├── default.nix           # Imports all home modules
    ├── packages.nix          # CLI tools always present on the host
    ├── shell/
    │   ├── default.nix       # Imports zsh and fish
    │   ├── zsh.nix           # Zsh config, aliases, functions (host shell)
    │   └── fish.nix          # Fish config, abbreviations, functions (Zellij shell)
    └── programs/
        ├── default.nix       # Shell-integrated tools (mise, zoxide, fzf, direnv, atuin)
        ├── git.nix           # Git + delta
        ├── mise.nix          # Mise (language runtime versioning)
        ├── ssh.nix           # SSH agent (Bitwarden)
        ├── starship.nix      # Prompt + starship.toml
        ├── ghostty.nix       # Terminal emulator
        ├── neovim.nix        # Neovim editor
        ├── helix.nix         # Helix editor + languages.toml
        ├── zellij.nix        # Terminal multiplexer
        └── yazi.nix          # File manager
```

## Package management

Packages are split between Homebrew and Nix for a specific reason: Mise compiles language runtimes (Node, Python, Ruby, etc.) from source and looks for build dependencies at hardcoded Homebrew paths like `/opt/homebrew/opt/openssl`. Those dependencies **must** be in Homebrew.

Everything else goes in Nix:

| What | Where | Why |
|---|---|---|
| Build essentials (gcc, openssl, readline, …) | `modules/darwin/homebrew.nix` → `brews` | Mise needs them at `/opt/homebrew/opt/` at compile time |
| GUI apps | `modules/darwin/homebrew.nix` → `casks` | macOS `.app` bundles; Nix doesn't handle these well |
| CLI tools | `modules/home/packages.nix` | Reproducible, version-locked, no Homebrew overhead |
| Language runtimes + LSPs | Mise (`~/.config/mise/`) | Per-project pinning, not managed here |

Never add a package to both Homebrew and Nix — pick one.

## What is and isn't managed here

| Layer | Tool | Notes |
|---|---|---|
| System packages + macOS prefs | nix-darwin | Homebrew casks, `system.defaults.*` |
| Dotfiles + user programs | home-manager | Shell configs, editors, terminal tools |
| Dev tool runtimes + LSPs | [Mise](https://mise.jdx.dev) | Node, Python, Rust, language servers — not managed here |
| Ubuntu VMs | [chezmoi](https://chezmoi.io) | Separate repo, separate toolchain |

Dev tools (language runtimes, LSPs, project tooling) are intentionally left to Mise. Use a `mise.toml` in each project for per-project pinning, or `~/.config/mise/config.toml` for global tool versions.

## Adding a new macOS host

1. Add a new directory under `hosts/`:
   ```bash
   mkdir -p hosts/My-Other-Mac
   ```

2. Create `hosts/My-Other-Mac/default.nix` and `home.nix`, importing the shared modules and setting the host-specific values (`nixpkgs.hostPlatform`, `system.primaryUser`, `home.username`, `home.homeDirectory`).

3. Add the new host to `flake.nix`:
   ```nix
   darwinConfigurations."My-Other-Mac" = nix-darwin.lib.darwinSystem {
     system = "aarch64-darwin"; # or x86_64-darwin
     modules = [ ... ];
   };
   ```

4. Bootstrap on the new machine:
   ```bash
   sudo nix run nix-darwin -- switch --flake .#My-Other-Mac
   ```

## Secrets

User-specific git config (`~/.config/git/local`) is not tracked in this repo. The Bitwarden SSH agent socket path is hardcoded in `modules/home/shell/zsh.nix` and `fish.nix` — update it if your socket path differs.
