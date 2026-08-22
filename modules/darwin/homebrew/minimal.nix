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
      "coreutils"

      # Core development tools
      "hf"
      "herdr"
      "mole"
      "nono"
      "opencode"

      # Docker via Colima (with QEMU for non-nested virtualization)
      "colima"
      "docker"
      "docker-compose"
      "qemu"
    ];

    casks = [
      "claude-code"
      "ghostty"
      "cmux"
    ];
  };
}
