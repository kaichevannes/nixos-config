{
  homeManager =
    { pkgs, ... }:
    {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "gruvbox-material-transparent";
          editor = {
            true-color = true;
            mouse = false;
            line-number = "relative";
            auto-pairs = false;
            rulers = [ 80 ];
          };
          keys = import ./keys.nix;
        };
        languages = import ./languages.nix;
        themes = import ./themes.nix;
      };
      home.packages = with pkgs; [
        nil
        nixfmt
        gopls
        delve
        gotools
        golangci-lint
        golangci-lint-langserver
        neocmakelsp
        typescript
        typescript-language-server
        vscode-langservers-extracted # HTML / CSS / JSON
        prettier
      ];
    };

}
