# dotfiles-nix

macOS system configuration using nix-darwin and home-manager.

## Stack

- **nix-darwin** — system-level config (macOS defaults, Homebrew)
- **home-manager** — user-level config (dotfiles, packages, shell)
- **Homebrew** — build essentials for Mise + GUI casks only
- **Mise** — language runtimes and LSPs (not managed here)

## Structure

```
flake.nix                         # entry point; defines hosts and shared variables
hosts/jmbp/         # host-specific config (platform, username, paths)
modules/
  darwin/                         # nix-darwin: system defaults, homebrew
  home/                           # home-manager: packages, shell, programs
    shell/zsh.nix, fish.nix       # zsh = host shell, fish = Zellij shell
    programs/                     # per-program configs and shell integrations
  claude/                         # deploys ~/.claude/CLAUDE.md via out-of-store symlink
```

## Key conventions

**Homebrew vs Nix split:**
- `modules/darwin/homebrew.nix` — build essentials (gcc, openssl, readline, etc.) that Mise needs at `/opt/homebrew/opt/` when compiling runtimes; GUI casks
- `modules/home/packages.nix` — everything else, installed via Nix into the user profile
- Never duplicate a package across both

**Module organisation:**
- Programs with shell integration (zoxide, fzf, atuin, etc.) live in `modules/home/programs/default.nix` with both `enableZshIntegration` and `enableFishIntegration` set
- Raw config files (helix/languages.toml, zellij/config.kdl, etc.) live alongside their `.nix` module file and are placed via `xdg.configFile`
- `modules/claude/CLAUDE.md` is symlinked out-of-store to `~/.claude/CLAUDE.md` — edit it directly without rebuilding

**Known quirks:**
- `nix.enable = false` is required — Determinate Systems manages the Nix installation, not nix-darwin
- `system.primaryUser = "jesse"` is required for user-scoped `system.defaults` and Homebrew options
- `home.homeDirectory` is set with `lib.mkForce` in `flake.nix` to override a null value injected by home-manager's `nixos/common.nix`
- `dotfilesDir` in `flake.nix` must match the actual clone path for out-of-store symlinks to work

## Validation and apply

```bash
just check    # validate flake before applying
just diff     # preview changes
just rebuild  # apply
```
