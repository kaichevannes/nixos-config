{
  homeManager =
    { ... }:
    {
      programs.tmux = {
        enable = true;
        disableConfirmationPrompt = true;
        escapeTime = 0;
        historyLimit = 50000;
        keyMode = "vi";
        terminal = "tmux-256color";
        extraConfig = ''
          set -g display-time 4000
          set -g renumber-windows on
          set -g status-interval 60
          set -g status-right ""
        '';
      };
    };
}
