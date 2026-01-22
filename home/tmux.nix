{ ... }: {
  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    extraConfig = ''
      set -g display-time 4000
      set -g renumber-windows on
      set -g status-interval 60
      set -g status-right ""
    '';
  };
}
