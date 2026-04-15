{ config, lib, ... }:
{
  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf config.profiles.desktop.enable {
    modules.user.enable = true;
    modules.gui.enable = true;
  };

  imports = [
    ./chromium.nix
    ./firefox.nix
  ];
}
