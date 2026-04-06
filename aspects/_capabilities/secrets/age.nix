{ pkgs, user, ... }:
let
  ageKeyDir = "/home/${user}/.config/sops/age";
  ageKeyFile = "${ageKeyDir}/keys.txt";
in
{
  systemd.user.services.generate-age-key = {
    description = "Generate Age key from SSH agent via ssh-to-age.";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "/run/current-system/sw/bin/mkdir -p ${ageKeyDir}"
        "/run/current-system/sw/bin/bash -c \"${pkgs.proton-pass-cli}/bin/pass-cli item view --vault-name Keys --item-title id_ed25519 --field private_key | ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i - > ${ageKeyFile}\""
      ];
    };
  };

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = ageKeyFile;

  sops.secrets = (import ../../secrets/manifest.nix { inherit user; });
}
