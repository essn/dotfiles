{ ... }: {
  # nix-darwin (master) regression: PAM sudo_local content is written to the
  # SSH config path, breaking SSH. Override with empty content until fixed upstream.
  environment.etc."ssh/ssh_config.d/100-nix-darwin.conf".text = "";
}
