{ lib, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--force" ];
    };

    taps = [
      "anomalyco/tap"
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
      "qemu"
      "e2fsprogs"
      "php"
      "leiningen"
      "coreutils"
      "amass"
      "subfinder"
      "llvm" # Faustlive, but keeping
      "go-parquet-tools"
      "jupyterlab"
      "hf"
      "herdr"
      "mole"
      "nono"
      "opencode"
    ];

    casks = [
      "claude-code"
      "ghostty"
      "cmux"
      "zap"
      "zed"
      "supercollider"
      "blackhole-16ch"
      "orbstack"
    ];
  };
}
