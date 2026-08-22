{
  profile ? "full",
  ...
}:
{
  imports = [
    (import ./packages { inherit profile; })
    ./shell
    ./programs
    ../claude
  ];
}
