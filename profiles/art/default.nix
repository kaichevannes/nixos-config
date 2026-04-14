{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.art = {
    enable = lib.mkEnableOption "art";
  };

  config = lib.mkIf config.profiles.art.enable {
    modules.gui.enable = true;

    environment.systemPackages = with pkgs; [
      krita
    ];

    hardware.opentabletdriver.enable = true;
  };
}
