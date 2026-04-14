{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
      };
    }
  ];
}
