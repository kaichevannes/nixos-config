{
  config,
  lib,
  pkgs,
  ...
}:
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

    home-manager.sharedModules = [
      {
        home.packages = with pkgs; [
          eza
          fzf
          ripgrep
          tokei
          zoxide
        ];
      }
    ];
  };

  imports = [
    ./ai.nix
    ./editor
    ./file-explorer
    ./git
    ./multiplexer.nix
    ./prompt.nix
    ./shell.nix
  ];
}
