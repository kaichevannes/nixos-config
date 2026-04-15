{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.modules.gui.enable {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd exec uwsm start hyprland.desktop";
      };
    };
  };
}
