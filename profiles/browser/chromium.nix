{ config, lib, ... }:
lib.mkIf config.profiles.browser.enable {
  home-manager.sharedModules = [
    {
      programs.chromium = {
        enable = true;
      };
    }
  ];
}
