{ config, lib, ... }:
lib.mkIf config.profiles.virtualisation.enable {
  virtualisation.docker.enable = true;
  users.users.${config.meta.username}.extraGroups = [ "docker" ];
}
