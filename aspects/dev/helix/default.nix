{
  homeManager =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        # Helix master from flake
        package = inputs.helix.packages.${pkgs.stdenv.hostPlatform.system}.helix;
        settings = {
          theme = "gruvbox-material-transparent";
          editor = {
            true-color = true;
            mouse = false;
            line-number = "relative";
            auto-pairs = false;
            rulers = [ 80 ];
          };
          keys = import ./keys.nix { inherit pkgs; };
        };
        languages = import ./languages.nix;
        themes = import ./themes.nix;
      };

      home.packages = with pkgs; [
        # LSP
        nil
        gopls
        delve
        gotools
        golangci-lint
        golangci-lint-langserver
        neocmakelsp
        typescript
        typescript-language-server
        vscode-langservers-extracted # HTML / CSS / JSON
        emmet-language-server
        texlab

        # Formatter
        prettier
        nixfmt
        libxml2
        tex-fmt

        # Debugger
        lldb
      ];
    };

}
