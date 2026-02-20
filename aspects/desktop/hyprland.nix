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
          };

          decoration = {
            rounding = 10;
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
