{ ... }:
{
  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";

        bind = [
          "$mod, F, fullscreen, toggle"
          "$mod, Q, killactive"
          "$mod, M, exit"

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

          "$mod, left, movefocus, l"
          "$mod, down, movefocus, d"
          "$mod, up, movefocus, u"
          "$mod, right, movefocus, r"
          "$mod+Shift, left, swapwindow, l"
          "$mod+Shift, down, swapwindow, d"
          "$mod+Shift, up, swapwindow, u"
          "$mod+Shift, right, swapwindow, r"
        ];
      };
    }
  ];
}
