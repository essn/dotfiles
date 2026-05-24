{ ... }:
{
  programs.zellij = {
    enable = true;
  };

  # Config managed as a plain KDL file — see zellij/config.kdl in this directory
  xdg.configFile."zellij/config.kdl".source = ./zellij/config.kdl;
}
