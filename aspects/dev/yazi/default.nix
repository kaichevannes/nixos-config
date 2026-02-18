{
  homeManager =
    { ... }:
    {
      programs.yazi = {
        enable = true;
        theme.mgr.syntect_theme = ./gruvbox-material.tmTheme;
      };
    };
}
