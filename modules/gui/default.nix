{ config, lib, ... }:
{
  options.modules.gui = {
    enable = lib.mkEnableOption "gui";
  };

  config = lib.mkIf config.modules.gui.enable {
    modules.user.enable = true;
    modules.secrets.enable = true;
  };

  imports = [
    ./foot.nix
    ./greetd.nix
    ./hyprland.nix
    ./vicinae.nix
  ];
}
