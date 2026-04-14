{ config, lib, ... }:
{
  options = {
    profiles.dev = {
      enable = lib.mkEnableOption "dev";
      gitUsername = lib.mkOption { type = lib.types.str; };
      gitEmail = lib.mkOption { type = lib.types.str; };
    };
  };

  config = lib.mkIf config.profiles.dev.enable {
    modules.user.enable = true;
    modules.ssh.enable = true;
  };

  imports = [
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
