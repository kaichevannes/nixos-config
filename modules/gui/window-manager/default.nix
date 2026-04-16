{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./keybindings.nix
    ./style.nix
  ];

  options.modules.gui.wm = {
    applications = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            workspace = lib.mkOption {
              type = lib.types.nullOr lib.types.ints.positive;
              default = null;
            };

            floating = lib.mkOption {
              type = lib.types.bool;
              default = false;
            };

            command = lib.mkOption {
              type = lib.types.str;
            };

            keybindings = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
            };
          };
        }
      );
      default = { };
    };
  };

  config = lib.mkIf config.modules.gui.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    home-manager.sharedModules = [
      {
        home.packages = with pkgs; [ wl-clipboard ];

        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;

          settings =
            let
              inherit (config.modules.gui.wm) applications;
              workspaces = lib.filterAttrs (_name: app: app.workspace != null) applications;
              launchers = lib.filterAttrs (_name: app: app.keybindings != [ ]) applications;
              floating = lib.filterAttrs (_name: app: app.floating) applications;
            in
            {
              monitor = [
                "desc:ASUSTek COMPUTER INC VG27A M3LMQS265113, 2560x1440@144, 0x0, 1"
              ];

              input = {
                kb_layout = "gb";
              };

              exec-once =
                lib.mapAttrsToList (
                  _name: app: "[workspace ${toString app.workspace} silent] ${app.command}"
                ) workspaces
                ++ lib.mapAttrsToList (
                  name: app: "[workspace special:${name} silent; float; size 1450 1050; center] ${app.command}"
                ) floating;

              workspace = lib.mapAttrsToList (
                name: app: "special:${name}, on-created-empty:${app.command}"
              ) floating;

              windowrule = lib.mapAttrsToList (
                name: app: "match:workspace special:${name}, float on, size 1450 1050, center on"
              ) floating;

              bind =
                lib.concatLists (
                  lib.mapAttrsToList (
                    name: app: map (keybinding: "${keybinding}, exec, ${app.command}") app.keybindings
                  ) (lib.filterAttrs (_name: app: !app.floating) launchers)
                )
                ++ lib.concatLists (
                  lib.mapAttrsToList (
                    name: app: map (keybinding: "${keybinding}, togglespecialworkspace, ${name}") app.keybindings
                  ) (lib.filterAttrs (_name: app: app.floating) launchers)
                );
            };
        };
      }
    ];
  };
}
