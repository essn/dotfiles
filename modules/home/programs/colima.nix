{
  config,
  dotfilesDir,
  profile ? "full",
  lib,
  ...
}:
lib.mkIf (profile == "minimal") {
  # Colima configuration for minimal profile (uses QEMU for non-nested virtualization)
  # The config file is symlinked out-of-store so it can be edited without rebuilding
  xdg.configFile."colima/default/colima.yaml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/home/programs/colima/default.yaml";
}
