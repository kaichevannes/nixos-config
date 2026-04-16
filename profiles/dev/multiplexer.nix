{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.profiles.dev = {
    popups = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.submodule {
          options = {
            key = lib.mkOption {
              type = lib.types.str;
            };
            command = lib.mkOption {
              type = lib.types.str;
            };
          };
        }
      );
      default = { };
    };
  };

  config = lib.mkIf config.profiles.dev.enable {
    home-manager.sharedModules = [
      {
        programs.tmux =
          let
            popupScripts = lib.mapAttrs (
              name: popup:
              pkgs.writeShellScript "popup-${name}" ''
                SESSION="${name}-$(echo "$1" | md5sum | cut -c1-8)"
                tmux has-session -t "$SESSION" 2>/dev/null || \
                  tmux new-session -d -s "$SESSION" -c "$1" ${popup.command}
                tmux set-option -t "$SESSION" status off
                tmux display-popup -w60% -h75% -E "tmux attach-session -t $SESSION"
              ''
            ) config.profiles.dev.popups;

            popupBindings = lib.concatStringsSep "\n" (
              lib.mapAttrsToList (
                name: popup: ''bind-key ${popup.key} run-shell "${popupScripts.${name}} '#{pane_current_path}'"''
              ) config.profiles.dev.popups
            );
          in
          {
            enable = true;
            escapeTime = 0;
            historyLimit = 50000;
            terminal = "tmux-256color";
            extraConfig = popupBindings;
          };
      }
    ];
  };
}
