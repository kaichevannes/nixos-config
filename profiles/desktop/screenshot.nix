{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.desktop.enable {
  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        grim
        slurp
      ];
    }
  ];

  modules.gui.wm.applications.screenshot = {
    command = "grim -g \"$(slurp)\" - | wl-copy";
    keybindings = [ "$mod+Shift, S" ];
  };
}
