{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    }
  ];
}
