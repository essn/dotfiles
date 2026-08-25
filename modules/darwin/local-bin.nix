{ dotfilesDir, ... }:
{
  # Wrappers for the Homebrew-installed opencode and claude casks.
  # Symlinked out-of-store so edits to the scripts take effect immediately
  # without running `just rebuild`
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        home.file.".local/bin/opencode".source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/local-bin/opencode";
        home.file.".local/bin/claude".source =
          config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/darwin/local-bin/claude";
      }
    )
  ];
}
