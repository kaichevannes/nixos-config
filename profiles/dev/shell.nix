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
      };
    }
  ];
}
