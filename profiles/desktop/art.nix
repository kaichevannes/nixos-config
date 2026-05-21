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
    modules.persist.homeDirectories = [
      {
        path = "Art";
        cloudBucket = "art";
      }
    ];

    environment.systemPackages = with pkgs; [
      krita
      pureref
    ];

    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
