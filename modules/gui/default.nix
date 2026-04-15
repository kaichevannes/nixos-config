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
    ./application-launcher.nix
    ./greeter.nix
    ./terminal.nix
    ./window-manager.nix
  ];
}
