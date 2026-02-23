{
  homeManager =
    { ... }:
    {
      programs.firefox = {
        enable = true;
        profiles.default.id = 0;
        profiles.focumon = {
          id = 1;
          settings = {
            "widget.wayland.vsync.enabled" = false;
          };
        };
      };
    };
}
