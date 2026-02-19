{
  homeManager =
    { ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
        theme.mgr.syntect_theme = ./gruvbox-material.tmTheme;
      };
    };
}
