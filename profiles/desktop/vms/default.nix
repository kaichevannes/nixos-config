{ config, lib, ... }:
{
  imports = [ ./virtualisation.nix ];

  options.profiles.desktop.vms = {
    enable = lib.mkEnableOption "virtualisation";
  };

  config = lib.mkIf config.profiles.desktop.vms.enable {
    modules.persist.homeDirectories = [ "Iso" ];

    programs.virt-manager = {
      enable = true;
    };
  };
}
