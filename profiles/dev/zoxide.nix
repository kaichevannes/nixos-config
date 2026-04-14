{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    }
  ];
}
