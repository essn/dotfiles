{
  profile ? "full",
  ...
}:
{
  imports = [
    (if profile == "minimal" then ./minimal.nix else ./full.nix)
  ];
}
