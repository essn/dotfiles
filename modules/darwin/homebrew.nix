{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    brews = [
      # Build essentials — kept in Homebrew so Mise can find them when
      # compiling language runtimes (Python, Ruby, etc.) from source
      "gcc"
      "openssl"
      "zlib"
      "bzip2"
      "readline"
      "sqlite"
      "ncurses"
      "xz"
      "tcl-tk"
      "libxml2"
      "libffi"
      "cmake"
      "just"
    ];
    casks = [
      "ghostty"
      "cmux"
    ];
  };
}
