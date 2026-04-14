{ config, lib, ... }:
{
  options.profiles.browser = {
    enable = lib.mkEnableOption "browser";
  };

  config = lib.mkIf config.profiles.browser.enable {
    modules.user.enable = true;
    modules.gui.enable = true;
  };

  imports = [
    ./chromium.nix
    ./firefox.nix
  ];
}
