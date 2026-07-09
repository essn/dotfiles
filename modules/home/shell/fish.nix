{ ... }:
{
  programs.fish = {
    enable = true;

    shellInit = ''
      # Disable greeting
      set -g fish_greeting

      # Homebrew
      eval (/opt/homebrew/bin/brew shellenv fish)

      # Path additions
      fish_add_path -gP ~/.local/bin
      fish_add_path -gP ~/bin
      fish_add_path -gP ~/.cargo/bin
      set -gx PATH $PATH $HOME/.krew/bin

      # OrbStack — CLI tools
      fish_add_path -aP ~/.orbstack/bin

      # Vi key bindings
      fish_vi_key_bindings
    '';

    interactiveShellInit = ''
      # Set Bitwarden SSH socket
      set -gx SSH_AUTH_SOCK "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"

      # Editor: prefer hx, fall back through nvim → vim → nano
      if command -q hx
          set -gx EDITOR hx
          set -gx VISUAL hx
      else if command -q nvim
          set -gx EDITOR nvim
          set -gx VISUAL nvim
      else if command -q vim
          set -gx EDITOR vim
          set -gx VISUAL vim
      else
          set -gx EDITOR nano
          set -gx VISUAL nano
      end

      # Pager
      if command -q less
          set -gx PAGER less
          set -gx LESS '-R -F -X'
      end

      # XDG Base Directory
      set -gx XDG_CONFIG_HOME ~/.config
      set -gx XDG_DATA_HOME ~/.local/share
      set -gx XDG_CACHE_HOME ~/.cache
      set -gx XDG_STATE_HOME ~/.local/state

      set -gx CLICOLOR 1

      # Ghostty terminfo fallback
      if not infocmp $TERM &>/dev/null 2>/dev/null
          set -gx TERM xterm-256color
      end

      # fzf integration
      if command -q fd
          set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
          set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
      end
      if command -q bat
          set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range :500 {}'"
      end

      # just completions
      if command -q just
          just --completions fish | source
      end

      # rbw completions
      if command -q rbw
          rbw gen-completions fish | source
      end
    '';

    shellAbbrs = {
      # Quick shortcuts
      f = "y";
      e = "$EDITOR";
      n = "nvim";
      j = "z";
      slj = "zellij";
      lg = "lazygit";
      k = "kubectl";
      cclb = "pbcopy < /dev/null";
      ptpy = "ptpython";

      # AGE
      age-enc = "age -R ~/.config/age/recipients.txt";
      age-dec = "age -d -i ~/.config/age/identity.txt";

      # Bitwarden
      bwu = "rbw unlock";
      bwl = "rbw lock";

      # Tool replacements
      l = "eza -l --icons";
      la = "eza -la --icons";
      ll = "eza -l --icons";
      lt = "eza -l --icons --tree";
      cat = "bat";
      find = "fd";

      # Git
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gd = "git diff";
      gl = "git log";
      gp = "git push";
      gpl = "git pull";
      gs = "git status";
      gb = "git branch";

      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Safety nets
      rm = "rimraf -i";
      cp = "cp -i";
      mv = "mv -i";
    };

    functions = {
      mkcd = {
        description = "Create a directory and cd into it";
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: mkcd <directory>"
              return 1
          end
          mkdir -p $argv[1]
          and cd $argv[1]
        '';
      };

      backup = {
        description = "Create a timestamped backup of a file or directory";
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: backup <file|directory>"
              return 1
          end
          set -l timestamp (date +%Y%m%d_%H%M%S)
          set -l backup_name "$argv[1].backup_$timestamp"
          cp -r $argv[1] $backup_name
          and echo "Backup created: $backup_name"
        '';
      };

      extract = {
        description = "Extract common archive formats";
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: extract <archive_file>"
              return 1
          end
          if not test -f $argv[1]
              echo "Error: '$argv[1]' is not a valid file"
              return 1
          end
          switch $argv[1]
              case '*.tar.bz2' '*.tbz2'
                  tar xjf $argv[1]
              case '*.tar.gz' '*.tgz'
                  tar xzf $argv[1]
              case '*.tar.xz'
                  tar xJf $argv[1]
              case '*.bz2'
                  bunzip2 $argv[1]
              case '*.gz'
                  gunzip $argv[1]
              case '*.tar'
                  tar xf $argv[1]
              case '*.zip'
                  unzip $argv[1]
              case '*.Z'
                  uncompress $argv[1]
              case '*.7z'
                  7z x $argv[1]
              case '*.rar'
                  unrar x $argv[1]
              case '*'
                  echo "Error: '$argv[1]' cannot be extracted via extract()"
                  return 1
          end
        '';
      };

      ff = {
        description = "Find files by name in current directory";
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: ff <pattern>"
              return 1
          end
          if command -q fd
              fd --type f $argv[1]
          else
              find . -type f -iname "*$argv[1]*"
          end
        '';
      };
    };
  };
}
