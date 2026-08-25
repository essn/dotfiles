{ pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
    ../../modules/nixos/packages.nix
  ];

  networking.hostName = "orbstack";

  # OrbStack handles DNS via its guest integration layer; resolved conflicts
  # with pointing resolv.conf at the host-provided path
  services.resolved.enable = false;
  networking.resolvconf.enable = false;
  environment.etc."resolv.conf".source = "/opt/orbstack-guest/etc/resolv.conf";

  # systemd-networkd for the container's virtual ethernet interface
  networking.useNetworkd = true;
  systemd.network = {
    enable = true;
    networks."10-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
    };
  };

  environment.extraInit = ''
    export PATH="/opt/orbstack-guest/bin:$PATH"
  '';

  # Enable x86_64 builds via Rosetta
  nix.extraOptions = "extra-platforms = x86_64-linux i686-linux";

  users.users.jesse = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.11";
}
