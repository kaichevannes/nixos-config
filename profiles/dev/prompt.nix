{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = false;
          profiles = {
            transient = "$character";
            rtransient = "";
          };
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

      programs.zsh.initContent = ''
        TRANSIENT_PROMPT="''${PROMPT// prompt / prompt --profile transient }"
        TRANSIENT_RPROMPT="''${PROMPT// prompt / prompt --profile rtransient }"

        autoload -Uz add-zle-hook-widget
        add-zle-hook-widget zle-line-finish transient-prompt

        function transient-prompt() {
            PROMPT="$TRANSIENT_PROMPT" RPROMPT="$TRANSIENT_RPROMPT" zle .reset-prompt
        }
      '';
    }
  ];
}
