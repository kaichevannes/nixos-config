{
  homeManager =
    { ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        theme.mgr.syntect_theme = ./gruvbox-material.tmTheme;
      };
    };
}
