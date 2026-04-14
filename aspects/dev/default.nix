{ lib, requires, ... }:
{
  options.meta = {
    gitHubUsername = lib.mkOption { type = lib.types.str; };
    gitHubEmail = lib.mkOption { type = lib.types.str; };
  };

  imports =
    requires [
      "user"
      "ssh"
    ]
    ++ [
      ./bat.nix
      ./claude.nix
      ./eza.nix
      ./fzf.nix
      ./git.nix
      ./helix
      ./lazygit
      ./starship.nix
      ./tmux.nix
      ./utils.nix
      ./yazi
      ./zoxide.nix
      ./zsh.nix
    ];
}
