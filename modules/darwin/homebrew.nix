{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--force" ];
    };
    taps = [
      "retlehs/tap"
    ];
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
      "retlehs/tap/quien"
      "qemu"
      "e2fsprogs"
      "php"
    ];
    casks = [
      "ghostty"
      "cmux"
      "zap"
    ];
  };
}
