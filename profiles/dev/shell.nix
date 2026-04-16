{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.dev.enable {
  # Completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];

  modules.persist.homeFiles = [ ".zsh_history" ];
  modules.persist.homeDirectories = [
    ".local/share/zoxide"
  ];

  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
  };

  home-manager.sharedModules = [
    {
      programs.eza.enable = true;
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        history.size = 10000;

        shellAliases = {
          ls = "eza";
        };

        initContent = ''
          eval "$(starship init zsh)"

          TRANSIENT_PROMPT="''${PROMPT// prompt / prompt --profile transient }"
          TRANSIENT_RPROMPT="''${PROMPT// prompt / prompt --profile rtransient }"

          autoload -Uz add-zle-hook-widget
          add-zle-hook-widget zle-line-finish transient-prompt

          function transient-prompt() {
              PROMPT="$TRANSIENT_PROMPT" RPROMPT="$TRANSIENT_RPROMPT" zle .reset-prompt
          }
        '';
      };
    }
  ];
}
