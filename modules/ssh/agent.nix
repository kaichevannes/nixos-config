{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.modules.secrets.enable {
  modules.persist.homeDirectories = [
    ".local/share/proton-pass-cli"
    ".local/share/keyrings"
  ];

  environment.systemPackages = with pkgs; [
    proton-pass-cli
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # https://protonpass.github.io/pass-cli/commands/ssh-agent/#setting-ssh_auth_sock-automatically-on-login
  systemd.user.services.proton-pass-ssh-agent = {
    description = "Proton Pass SSH Agent";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent start --socket-path %t/proton-pass-agent.sock";
      Restart = "on-failure";
    };
  };

  environment.sessionVariables = {
    PROTON_PASS_KEY_PROVIDER = "keyring";
    PROTON_PASS_LINUX_KEYRING = "dbus";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/proton-pass-agent.sock";
  };

  home-manager.sharedModules = [
    {
      programs.zsh.initContent = ''
        if ! systemctl --user is-active --quiet proton-pass-ssh-agent; then
          echo "Proton Pass SSH Agent isn't running, run pass-ssh to start"
        fi

        pass-ssh() {
          if ! pass-cli test &>/dev/null; then
            echo "→ Proton Pass Login..."
            pass-cli login || return 1
          fi
          echo "→ Starting SSH Agent..."
          systemctl --user start proton-pass-ssh-agent
          systemctl --user status proton-pass-ssh-agent --no-pager
        }
      '';
    }
  ];
}
