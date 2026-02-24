{ pkgs, ... }:
{
  imports = [ ../proton-ssh/nixos.nix ];

  systemd.user.services.generate-age-key = {
    description = "Generate Age key from SSH agent via ssh-to-age";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.coreutils}/bin/mkdir -p %h/.config/sops/age"
        "${pkgs.bash}/bin/bash -c \"${pkgs.proton-pass-cli}/bin/pass-cli item view --vault-name Keys --item-title id_ed25519 --field private_key | ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i - > %h/.config/sops/age/keys.txt\""
        "${pkgs.coreutils}/bin/chmod 600 %h/.config/sops/age/keys.txt"
      ];
    };
  };
}
