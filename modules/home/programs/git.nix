{ ... }: {
  programs.git = {
    enable = true;

    # User-specific settings (name, email, signingKey) live in
    # ~/.config/git/local which is not tracked in this repo.
    # Create it with:
    #
    #   [user]
    #     name = Your Name
    #     email = you@example.com
    #     signingkey = ssh-ed25519 AAAA...
    #
    includes = [
      { path = "~/.config/git/local"; }
    ];

    settings = {
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch = {
        prune = true;
        pruneTags = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv"
      ".envrc"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
    };
  };
}
