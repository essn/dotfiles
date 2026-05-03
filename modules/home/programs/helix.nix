{ ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "onedark";

      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        undercurl = true;
        color-modes = true;
        auto-format = true;

        statusline.right = [
          "diagnostics"
          "selections"
          "register"
          "position"
          "total-line-numbers"
          "file-encoding"
        ];

        lsp.display-inlay-hints = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker.hidden = false;

        whitespace.render = {
          space = "all";
          tab = "all";
          nbsp = "all";
          nnbsp = "all";
          newline = "none";
        };

        indent-guides.render = true;
      };
    };
  };

  # languages.toml managed as a plain file — LSP/formatter config tends to
  # change frequently and is easier to maintain outside the Nix attrset
  xdg.configFile."helix/languages.toml".source = ./helix/languages.toml;
}
