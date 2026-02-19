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
        };
      };

      home.packages = with pkgs; [
        wayland
      ];
    };
}
