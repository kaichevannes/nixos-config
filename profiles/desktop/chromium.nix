{ config, lib, ... }:
lib.mkIf config.profiles.desktop.enable {
  home-manager.sharedModules = [
    {
      programs.chromium = {
        enable = true;
      };
    }
  ];
}
