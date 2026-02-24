{
  nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        proton-pass-cli
      ];

      environment.sessionVariables = {
        PROTON_PASS_KEY_PROVIDER = "fs";
      };

      systemd.user.services.pass-cli-ssh-agent = {
        description = "Load Proton Pass SSH keys";
        after = [ "default.target" ];
        wantedBy = [ "default.target" ];

        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent start";
          Restart = "on-failure";
          RestartSec = 10;
        };

        # Stop restarting after 3 failed attempts.
        startLimitBurst = 3;
      };

      environment.sessionVariables = {
        SSH_AUTH_SOCK = "$HOME/.ssh/proton-pass-agent.sock";
      };
    };

  homeManager = {
    programs.zsh.initContent = ''
      if [[ -o interactive ]] then
        {
          pass-cli test >/dev/null 2>&1 || echo "Proton Pass CLI is not authenticated. Run 'pass-cli login'."
        } &!
      fi
    '';

    programs.zsh.shellAliases = {
      pass-login = "pass-cli login && systemctl --user start proton-pass-ssh-agent";
    };
  };
}
