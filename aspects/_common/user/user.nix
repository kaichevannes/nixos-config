{ config, ... }:
let
  inherit (config.meta) username;
in
{
  sops.secrets."password_${username}".neededForUsers = true;

  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."password_${username}".path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root -"
  ];
}
