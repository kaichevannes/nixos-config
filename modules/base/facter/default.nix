{ config, ... }:
{
  # Facter sets up: bluetooth, wifi, networking, hostplatform,
  #     virtualization type, usb, storage devices, etc.
  hardware.facter.reportPath = ../../../hosts/${config.meta.hostname}/facter.json;

  # Custom facter modules
  imports = [
    ./nvidia.nix
  ];
}
