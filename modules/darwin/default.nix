{ ... }:
{
  imports = [
    ./system-defaults.nix
    ./homebrew.nix
    ./security.nix
    ./local-bin.nix
    ./nono.nix
    ./opencode.nix
  ];
}
