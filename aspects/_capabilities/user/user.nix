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
}
