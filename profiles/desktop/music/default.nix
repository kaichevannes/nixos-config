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
    environment.systemPackages = with pkgs; [
      reaper
    ];
  };
}
