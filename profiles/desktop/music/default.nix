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
    modules.secrets.enable = true;
    modules.secrets.homeFiles = [
      ".config/REAPER/reaper-license.rk"
    ];

    services.pipewire.jack.enable = true;

    environment.systemPackages = with pkgs; [
      reaper
    ];
  };
}
