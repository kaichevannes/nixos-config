{ config, lib, ... }:
{
  options.profiles.dev.docker = {
    enable = lib.mkEnableOption "docker";
  };

  config = lib.mkIf config.profiles.dev.docker.enable {
    virtualisation.docker.enable = true;
    users.users.${config.meta.username}.extraGroups = [ "docker" ];
  };
}
