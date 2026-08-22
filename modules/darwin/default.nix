{
  profile ? "full",
  ...
}:
{
  imports = [
    ./system-defaults.nix
    (import ./homebrew { inherit profile; })
    ./security.nix
  ];
}
