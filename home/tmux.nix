{ ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    extraConfig = ''
      display-time = 4000;
      renumber-windows = "on"
      status-interval = 60;
    '';
  };
}
