{
  nixos =
    { ... }:
    {
      programs.hyprland = {
        enable = true;
      };
    };

  homeManager =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          "$mod" = "SUPER";
          "$terminal" = "foot";

          bind = [
            "$mod, Q, exec, $terminal"
            "$mod, M, exit"
          ];

          input = {
            kb_layout = "gb";
          };
        };
      };
    };
}
