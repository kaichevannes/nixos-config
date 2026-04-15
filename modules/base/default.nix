{ config, lib, ... }:
{
  options.meta = {
    hostname = lib.mkOption { type = lib.types.str; };
    description = lib.mkOption { type = lib.types.str; };
  };

  config = {
    # Facter sets up: bluetooth, wifi, networking, hostplatform,
    #     virtualization type, usb, storage devices, etc.
    hardware.facter.reportPath = ../../hosts/${config.meta.hostname}/facter.json;
    networking.hostName = config.meta.hostname;
    system.stateVersion = "25.11";
  };

  imports = [
    ./boot.nix
    ./filesystem
    ./hardware
    ./localisation.nix
    ./nix.nix
  ];
}
