{ config, lib, ... }:
{
  options = {
    meta.username = lib.mkOption { type = lib.types.str; };
    modules.user = {
      enable = lib.mkEnableOption "user";
    };
  };

  config =
    let
      inherit (config.meta) username;
    in
    lib.mkIf config.modules.user.enable {
      modules.secrets.enable = true;

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
    };

  imports = [
    ./home-manager.nix
  ];
}
