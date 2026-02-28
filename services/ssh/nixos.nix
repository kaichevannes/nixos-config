{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-pass-cli
  ];

  systemd.user.services.pass-cli-ssh-agent = {
    description = "Load Proton Pass SSH keys";
    after = [ "default.target" ];
    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent load";
      Restart = "on-failure";
      RestartSec = 10;
    };

    # Stop restarting after 3 failed attempts.
    startLimitBurst = 3;
  };

  environment.sessionVariables = {
    PROTON_PASS_KEY_PROVIDER = "fs";
    SSH_AUTH_SOCK = "$HOME/.ssh/proton-pass-agent.sock";
  };
}
