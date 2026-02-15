{ pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./git.nix
    ./tmux.nix
    ./eza.nix
    ./zoxide.nix
    ./yazi.nix

    ./lazygit
    ./helix
    ./zsh
  ];

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.packages = with pkgs; [
    fzf
    ripgrep
    tree
    tokei
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
}
