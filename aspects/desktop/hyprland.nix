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

            border_size = 0;
          };

          decoration = {
            rounding = 10;
          };

          animations = {
            bezier = [
              "myBezier, 0.05, 0.9, 0.1, 1.05"
            ];
            animation = [
              "windows, 1, 5, myBezier, slide"
              "windowsOut, 1, 5, myBezier, slide"
              "windows, 1, 6, myBezier, popin 80%"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
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
        extensions = [
          (config.lib.vicinae.mkExtension {
            name = "nix";
            src =
              pkgs.fetchFromGitHub {
                owner = "vicinaehq";
                repo = "extensions";
                rev = "cf30b80f619282d45b1748eb76e784a4f875bb01";
                sha256 = "sha256-KwNv+THKbNUey10q26NZPDMSzYTObRHaSDr81QP9CPY=";
              }
              + "/extensions/nix";
          })
        ];
      };
    };
}
