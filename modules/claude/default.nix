{ config, dotfilesDir, ... }: {
  # Symlinked out-of-store so edits to modules/claude/CLAUDE.md take
  # effect immediately without running `just rebuild`
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/modules/claude/CLAUDE.md";
}
