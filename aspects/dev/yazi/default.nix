{
  homeManager =
    { ... }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        shellWrapperName = "y";
        theme = {
          mgr.syntect_theme = ./gruvbox-material.tmTheme;
          # https://github.com/sxyazi/yazi/blob/884c265de1b4a05c96233fe1d4c37955ff0c032e/yazi-config/preset/theme-dark.toml#L682
          icon.prepend_exts = [
            {
              name = "html";
              text = "";
              fg = "#e44d26";
            }
            {
              name = "js";
              text = "";
              fg = "#cbcb41";
            }
            {
              name = "svg";
              text = "";
              fg = "#ffb13b";
            }
            {
              name = "mp3";
              text = "󰝚";
              fg = "#00afff";
            }
            {
              name = "mp4";
              text = "";
              fg = "#fd971f";
            }
            {
              name = "zip";
              text = "󰛫";
              fg = "#eca517";
            }
          ];
        };
      };
    };
}
