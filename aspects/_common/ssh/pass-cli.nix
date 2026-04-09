{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    proton-pass-cli
  ];

  # sops.secrets.proton_pass_encryption_key = { };
  # sops.secrets.proton_pass_personal_access_token = { };

  # sops.templates.proton-pass-env.content = ''
  #   PROTON_PASS_KEY_PROVIDER=env
  #   PROTON_PASS_ENCRYPTION_KEY=${config.sops.placeholder.proton_pass_encryption_key}
  #   PROTON_PASS_PERSONAL_ACCESS_TOKEN=${config.sops.placeholder.proton_pass_personal_access_token}
  # '';

  systemd.user.services.proton-pass-ssh-agent = {
    description = "Proton Pass SSH Agent";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      # EnvironmentFile = config.sops.templates.proton-pass-env.path;
      ExecStartPre = "${pkgs.proton-pass-cli}/bin/pass-cli pass-cli login";
      ExecStart = "${pkgs.proton-pass-cli}/bin/pass-cli ssh-agent start";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  environment.sessionVariables = {
    PROTON_PASS_KEY_PROVIDER = "fs";
    SSH_AUTH_SOCK = "$HOME/.ssh/proton-pass-agent.sock";
  };
}
