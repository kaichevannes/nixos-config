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

          font = {
            normal = {
              family = "auto";
              size = 12;
            };
          };

          launcher_window = {
            compact_mode.enabled = true;
          };

          favorites = [ ];

          providers = {
            browser-extensions.enabled = false;
            core.enabled = false;
            clipboard.enabled = false;
            developer.enabled = false;
            files.enabled = false;
            font.enabled = false;
            manage-shortcuts.enabled = false;
            power.enabled = false;
            raycast-compact.enabled = false;
            system.enabled = false;
            theme.enabled = false;
            wm.enabled = false;

            applications.enabled = true;
          };
        };
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
