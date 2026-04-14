{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.tmux =
        let
          claudeToggle = pkgs.writeShellScript "claude_toggle" ''
            SESSION="claude-$(echo "$1" | md5sum | cut -c1-8)"
            tmux has-session -t "$SESSION" 2>/dev/null || \
              tmux new-session -d -s "$SESSION" -c "$1" claude
              tmux set-option -t "$SESSION" status off
            tmux display-popup -w60% -h75% -E "tmux attach-session -t $SESSION"
          '';
        in
        {
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

            bind-key a run-shell "${claudeToggle} '#{pane_current_path}'"
          '';
        };
    }
  ];
}
