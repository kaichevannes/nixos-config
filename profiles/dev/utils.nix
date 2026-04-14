{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        ripgrep
        tokei
      ];
    }
  ];
}
