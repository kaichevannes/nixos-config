{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.desktop.art = {
    enable = lib.mkEnableOption "art";
  };

  config = lib.mkIf config.profiles.desktop.art.enable {
    environment.systemPackages = with pkgs; [
      krita
    ];

    hardware.opentabletdriver.enable = true;
  };
}
