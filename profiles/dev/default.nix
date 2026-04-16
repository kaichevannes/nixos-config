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

    modules.persist.homeDirectories = [ "Projects" ];

    home-manager.sharedModules = [
      {
        home.packages = with pkgs; [
          ripgrep
          tokei
        ];
      }
    ];
  };

  imports = [
    ./ai.nix
    ./docker
    ./editor
    ./file-explorer
    ./git
    ./multiplexer.nix
    ./prompt.nix
    ./shell.nix
  ];
}
