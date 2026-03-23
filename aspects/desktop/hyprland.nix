{
  nixos =
    { ... }:
    {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

  homeManager =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [
        wl-clipboard
        capitaine-cursors
        grim
        slurp
      ];

      programs.zsh.profileExtra = ''
        if [ -z "$WAYLAND_DISPLAY" ] && uwsm check may-start; then
            exec uwsm start hyprland.desktop
        fi
      '';

      wayland.windowManager.hyprland = {
        enable = true;

        settings =
          let
            llmUrl = "https://claude.ai";
            floatingWindowSize = "1450 1050";
          in
          {
            "$mod" = "SUPER";
            "$terminal" = "foot";
            "$bootstrapTerminal" = "foot --font=monospace:size=22";
            "$browser" = "firefox";
            "$workbrowser" = "firefox -P work";

            monitor = [
              "desc:ASUSTek COMPUTER INC VG27A M3LMQS265113, 2560x1440@144, 0x0, 1"
            ];

            exec-once = [
              "hyprctl setcursor capitaine-cursors 32"
              "[workspace 1 silent] if fc-list | grep -q DankMono; then exec $terminal; else exec $bootstrapTerminal; fi"
              "[workspace 2 silent] firefox -P default"
              "[workspace 5 silent] MOZ_ENABLE_WAYLAND=0 firefox -P focumon https://focumon.com --kiosk"
              "[workspace special:llm silent; float; size ${floatingWindowSize}; center] firefox --no-remote -P llm --new-window ${llmUrl}"
              "[workspace special:whatsapp silent; float; size ${floatingWindowSize}; center] firefox --no-remote -P whatsapp --new-window https://web.whatsapp.com/"
            ];

            workspace = [
              "special:llm, on-created-empty:firefox --no-remote -P llm --new-window ${llmUrl}"
              "special:whatsapp, on-created-empty:firefox --no-remote -P whatsapp --new-window https://web.whatsapp.com/"
            ];

            windowrule = [
              "match:workspace special:llm, float on, size ${floatingWindowSize}, center on"
              "match:workspace special:whatsapp, float on, size ${floatingWindowSize}, center on"
            ];

            bind = [
              "$mod, T, exec, if fc-list | grep -q DankMono; then exec $terminal; else exec $bootstrapTerminal; fi"
              "$mod+Shift, T, exec, bash -c \"$terminal 2>/tmp/terminal-error.log\""
              "$mod, B, exec, $browser"
              "$mod+Shift, B, exec, $workbrowser"
              "$mod, D, exec, vicinae toggle"
              "$mod+Shift, S, exec, grim -g \"$(slurp)\" - | wl-copy"
              "$mod, A, togglespecialworkspace, llm"
              "Alt, A, togglespecialworkspace, llm"
              "$mod, W, togglespecialworkspace, whatsapp"

              "$mod, 1, workspace, 1"
              "$mod, 2, workspace, 2"
              "$mod, 3, workspace, 3"
              "$mod, 4, workspace, 4"
              "$mod, 5, workspace, 5"
              "$mod, 6, workspace, 6"
              "$mod, 7, workspace, 7"
              "$mod, 8, workspace, 8"
              "$mod, 9, workspace, 9"
              "$mod, 0, workspace, 10"

              "$mod+Shift, code:10, movetoworkspace, 1"
              "$mod, code:34, movetoworkspace, 2"
              "$mod+Shift, code:34, movetoworkspace, 3"
              "$mod+Shift, code:18, movetoworkspace, 4"
              "$mod+Shift, code:21, movetoworkspace, 5"
              "$mod+Shift, code:17, movetoworkspace, 6"
              "$mod+Shift, code:19, movetoworkspace, 7"
              "$mod+Shift, code:35, movetoworkspace, 8"
              "$mod, code:35, movetoworkspace, 9"
              "$mod, code:51, movetoworkspace, 10"

              "$mod, h, movefocus, l"
              "$mod, j, movefocus, d"
              "$mod, k, movefocus, u"
              "$mod, l, movefocus, r"
              "$mod, left, movefocus, l"
              "$mod, down, movefocus, d"
              "$mod, up, movefocus, u"
              "$mod, right, movefocus, r"

              "$mod+Shift, h, swapwindow, l"
              "$mod+Shift, j, swapwindow, d"
              "$mod+Shift, k, swapwindow, u"
              "$mod+Shift, l, swapwindow, r"
              "$mod+Shift, left, swapwindow, l"
              "$mod+Shift, down, swapwindow, d"
              "$mod+Shift, up, swapwindow, u"
              "$mod+Shift, right, swapwindow, r"

              "$mod, F, fullscreen, toggle"
              "$mod, Q, killactive"
              "$mod, M, exit"
            ];

            cursor = {
              no_warps = true;
              hide_on_key_press = false;
            };

            input = {
              kb_layout = "gb";
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
      };
    };
}
