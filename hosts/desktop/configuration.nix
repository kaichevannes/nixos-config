{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.cheva = import ./home.nix;

  system.stateVersion = "25.11";
}
