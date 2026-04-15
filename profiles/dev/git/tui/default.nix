{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.lazygit = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          git.overrideGpg = true;
          customCommands = import ./custom-commands.nix;
          disableStartupPopups = true;
        };
      };
    }
  ];
}
