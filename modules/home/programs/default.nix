{ ... }:
{
  imports = [
    ./git.nix
    ./mise.nix
    ./ssh.nix
    ./starship.nix
    ./ghostty.nix
    ./neovim.nix
    ./helix.nix
    ./zellij.nix
    ./yazi.nix
  ];

  # Zoxide — smart cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Fzf — fuzzy finder with fd and bat integration
  # Note: fzf Fish integration only handles key bindings; env vars are set in fish.nix
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidget = {
      command = "fd --type f --hidden --exclude .git";
      options = [ "--preview 'bat --color=always {}'" ];
    };
    changeDirWidget.command = "fd --type d --hidden --exclude .git";
    # Atuin owns Ctrl-R for history search; disable fzf's binding to avoid the conflict
    historyWidget.command = "";
  };

  # Direnv — per-directory env vars, with nix-direnv for flake support
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  # Atuin — shell history sync and search
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Starship — fish integration (zsh integration handled in starship.nix)
  programs.starship.enableFishIntegration = true;
}
