{ ... }:
{
  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    autocd = true;

    shellAliases = {
      # Quick shortcuts
      f = "y";
      e = "$EDITOR";
      j = "z";
      lg = "lazygit";
      k = "kubectl";
      slj = "zellij";
      n = "nvim";
      ptpy = "ptpy";

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

      # AGE encryption
      age-enc = "age -R ~/.config/age/recipients.txt";
      age-dec = "age -d -i ~/.config/age/identity.txt";

      # Bitwarden
      bwu = "rbw unlock";
      bwl = "rbw lock";

      # Clipboard
      cclb = "pbcopy < /dev/null";

      # Directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Safety nets
      rm = "rimraf -i";
      cp = "cp -i";
      mv = "mv -i";
    };

    initContent = ''
      # Homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # OrbStack — CLI tools and shell integration
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :

      # Editor: prefer hx, fall back through nvim → vim → nano
      if command -v hx &>/dev/null; then
        export EDITOR=hx VISUAL=hx
      elif command -v nvim &>/dev/null; then
        export EDITOR=nvim VISUAL=nvim
      elif command -v vim &>/dev/null; then
        export EDITOR=vim VISUAL=vim
      else
        export EDITOR=nano VISUAL=nano
      fi

      # Path
      export PATH="$HOME/.krew/bin:$PATH"

      # Pager
      export PAGER=less
      export LESS='-R -F -X'

      # Ghostty terminfo fallback — avoids errors on hosts without Ghostty's terminfo
      if ! infocmp "$TERM" &>/dev/null 2>&1; then
        export TERM=xterm-256color
      fi

      # Yazi file manager wrapper — preserves cwd on exit
      y() {
        local tmp cwd
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }

      # Create a directory and cd into it
      mkcd() {
        if [ $# -eq 0 ]; then
          echo "Usage: mkcd <directory>"
          return 1
        fi
        mkdir -p "$1" && cd "$1"
      }

      # Timestamped backup of a file or directory
      backup() {
        if [ $# -eq 0 ]; then
          echo "Usage: backup <file|directory>"
          return 1
        fi
        local timestamp
        timestamp="$(date +%Y%m%d_%H%M%S)"
        cp -r "$1" "''${1}.backup_''${timestamp}" && echo "Backup created: ''${1}.backup_''${timestamp}"
      }

      # Extract common archive formats
      extract() {
        if [ $# -eq 0 ] || [ ! -f "$1" ]; then
          echo "Usage: extract <archive_file>"
          return 1
        fi
        case "$1" in
          *.tar.bz2|*.tbz2) tar xjf "$1"    ;;
          *.tar.gz|*.tgz)   tar xzf "$1"    ;;
          *.tar.xz)         tar xJf "$1"    ;;
          *.bz2)            bunzip2 "$1"    ;;
          *.gz)             gunzip "$1"     ;;
          *.tar)            tar xf "$1"     ;;
          *.zip)            unzip "$1"      ;;
          *.Z)              uncompress "$1" ;;
          *.7z)             7z x "$1"       ;;
          *.rar)            unrar x "$1"    ;;
          *) echo "Cannot extract '$1'"; return 1 ;;
        esac
      }

      # Find files by name in current directory
      ff() {
        if [ $# -eq 0 ]; then
          echo "Usage: ff <pattern>"
          return 1
        fi
        if command -v fd &>/dev/null; then
          fd --type f "$1"
        else
          find . -type f -iname "*$1*"
        fi
      }
    '';
  };

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME = "$HOME/.local/state";
    CLICOLOR = "1";
    SSH_AUTH_SOCK = "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
  };
}
