{ pkgs, ... }:
{
  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        capitaine-cursors
      ];

      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "hyprctl setcursor capitaine-cursors 32"
        ];

        cursor = {
          no_warps = true;
          hide_on_key_press = false;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        general = {
          resize_on_border = true;
          gaps_in = 8;
          gaps_out = 8;
          border_size = 0;
          layout = "master";
        };

        bezier = [
          "easeOut, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "specialWorkspace, 1, 4, easeOut, fade"
        ];

        decoration = {
          rounding = 16;
        };
      };
    }
  ];
}
