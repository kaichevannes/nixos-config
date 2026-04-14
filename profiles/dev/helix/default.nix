{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
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
        # Format
        libxml2
        prettier
        tex-fmt
        nixfmt

        # LSP
        delve
        docker-compose-language-service
        emmet-language-server
        gopls
        gotools
        golangci-lint
        golangci-lint-langserver
        nil
        neocmakelsp
        texlab
        typescript
        typescript-language-server
        vscode-langservers-extracted # HTML / CSS / JSON
        yaml-language-server

        # Debug
        lldb
      ];
    }
  ];
}
