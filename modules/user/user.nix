{ config, lib, ... }:
let
  inherit (config.meta) username;
in
lib.mkIf config.modules.user.enable {
  sops.secrets."password_${username}".neededForUsers = true;

  users.users.${username} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."password_${username}".path;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  security.sudo.extraConfig = "Defaults lecture=never";
}
