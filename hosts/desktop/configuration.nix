{ config, ... }:
{
  imports = [
    ../../system
    ./hardware-configuration.nix
    ./settings.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "25.11";
}
