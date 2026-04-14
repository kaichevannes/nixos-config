{ config, ... }:
{
  virtualisation.docker.enable = true;
  users.users.${config.meta.username}.extraGroups = [ "docker" ];
}
