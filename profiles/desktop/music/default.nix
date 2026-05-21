{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.desktop.music = {
    enable = lib.mkEnableOption "music";
  };

  config = lib.mkIf config.profiles.desktop.music.enable {
    modules.persist.homeDirectories = [ ".mixxx" ];

    environment.systemPackages = with pkgs; [
      mixxx
    ];
  };

  imports = [
    ./daw.nix
  ];
}
