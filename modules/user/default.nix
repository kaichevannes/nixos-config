{ config, lib, ... }:
{
  options = {
    meta.username = lib.mkOption { type = lib.types.str; };
    modules.user = {
      enable = lib.mkEnableOption "user";
    };
  };

  config = lib.mkIf config.modules.user.enable {
    modules.secrets.enable = true;
  };

  imports = [
    ./home-manager.nix
    ./user.nix
  ];
}
