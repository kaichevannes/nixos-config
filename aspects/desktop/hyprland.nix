{
  nixos =
    { ... }:
    {
      programs.hyprland = {
        enable = true;
      };
    };

  homeManager =
    { config, pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "foot";
          "$fileManager" = "yazi";
          "$browser" = "firefox";

          exec-once = [
            "vicinae server"
          ];

          bind = [
            "$mod, T, exec, $terminal"
            "$mod, B, exec, $browser"
            "$mod, F, exec, $fileManager"
            "$mod, D, exec, vicinae toggle"
            "$mod, Q, killactive"
            "$mod, M, exit"
          ];

          input = {
            kb_layout = "gb";
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };

          general = {
            gaps_in = 5;
            gaps_out = 5;

            border_size = 2;

            "col.active_border" = "rgb(131521)";
            "col.inactive_border" = "rgb(07080f)";
          };

          decoration = {
            rounding = 10;
          };

          animations = {
            bezier = [
              "wind, 0.05, 0.9, 0.1, 1.05"
              "winIn, 0.1, 1.1, 0.1, 1.1"
              "winOut, 0.3, -0.3, 0, 1"
              "liner, 1, 1, 1, 1"
            ];
            animation = [
              "windows, 1, 6, wind, slide"
              "windowsIn, 1, 6, winIn, slide"
              "windowsOut, 1, 5, winOut, slide"
              "windowsMove, 1, 5, wind, slide"
              "border, 1, 1, liner"
              "borderangle, 1, 30, liner, loop"
              "fade, 1, 10, default"
              "workspaces, 1, 5, wind"
            ];
          };
        };
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

      programs.vicinae = {
        enable = true;
        package = pkgs.vicinae;
        # extensions = [
        #   (config.lib.vicinae.mkExtension {
        #     name = "nix";
        #     src =
        #       pkgs.fetchFromGithub {
        #         owner = "vicinaehq";
        #         repo = "vicinae-extensions";
        #         rev = "cf30b80f619282d45b1748eb76e784a4f875bb01";
        #         sha256 = "";
        #       }
        #       + "/extensions/nix";
        #   })
        # ];
      };
    };
}
