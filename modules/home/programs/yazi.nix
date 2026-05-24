{ pkgs, ... }:
let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "ac82af3e10f9a32cecd9f87ac64b3f9de7c7aea7";
    hash = "sha256-svc7I2E+tVMEUWUvIS6i3oTGfLq13eaI61T0c1MQ8qQ=";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    shellWrapperName = "y";  # adopt new default, matches the `y` abbr/alias
    plugins = {
      full-border  = "${yaziPlugins}/full-border.yazi";
      git          = "${yaziPlugins}/git.yazi";
      smart-enter  = "${yaziPlugins}/smart-enter.yazi";
    };
  };

  xdg.configFile."yazi/yazi.toml".source = ./yazi/yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ./yazi/keymap.toml;
  xdg.configFile."yazi/init.lua".source = ./yazi/init.lua;
}
