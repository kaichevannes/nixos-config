{
  homeManager =
    { config, pkgs, ... }:
    {
      programs.vicinae = {
        enable = true;
        package = pkgs.vicinae;
        systemd = {
          enable = true;
          autoStart = true;
        };
        settings = {
          escape_key_behaviour = "close_window";
        };
      };

      wayland.windowManager.hyprland = {
        extraConfig = ''
          layerrule {
            name = vicinae-blur
            blur = on
            ignore_alpha = 0
            match:namespace = vicinae
          }

          layerrule {
            name = vicinae-no-animation
            no_anim = on
            match:namespace = vicinae
          }
        '';
      };
    };
}
