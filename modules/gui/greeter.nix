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
        command = "${pkgs.greetd}/bin/agreety --cmd '${lib.getExe pkgs.uwsm} start hyprland-uwsm.desktop'";
      };
    };
  };
}
