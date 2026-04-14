{ config, lib, ... }:
lib.mkIf config.profiles.virtualisation.enable {
  programs.virt-manager = {
    enable = true;
  };
}
