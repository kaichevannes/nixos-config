{
  homeManager =
    { ... }:
    {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        enableTransience = true;
        settings = {
          add_newline = false;
          character = {
            success_symbol = "[>](green)";
            error_symbol = "[>](red)";
            vimcmd_symbol = "[<](green)";
            vimcmd_replace_one_symbol = "[<](purple)";
            vimcmd_replace_symbol = "[<](purple)";
            vimcmd_visual_symbol = "[<](yellow)";
          };
          directory.style = "blue";
          git_branch.disabled = true;
          git_status = {
            style = "red";
            ahead = ">";
            behind = "<";
            deleted = "x";
          };
          status.symbol = "[x](red) ";
          cmd_duration = {
            format = "[$duration]($style)";
            style = "yellow";
          };
          fill.symbol = " ";
          format = "$all$fill$cmd_duration$status$line_break$character";
        };
      };

      home.file.".config/fish/conf.d/starship.fish".text = ''
        # > on previous line instead of unicode
        function starship_transient_prompt_func
          starship module character
        end
      '';
    };
}
