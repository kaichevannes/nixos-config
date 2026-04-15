{ config, lib, ... }:
{
  options.profiles.virtualisation = {
    enable = lib.mkEnableOption "virtualisation";
  };

  config = lib.mkIf config.profiles.virtualisation.enable {
    modules.user.enable = true;
    modules.gui.enable = true;

    modules.persist.userDirectories = [ "iso" ];
  };

  imports = [
    ./docker.nix
    ./libvirtd.nix
    ./virt-manager.nix
  ];
}
