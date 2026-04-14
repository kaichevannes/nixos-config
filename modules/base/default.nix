{ lib, ... }:
{
  options.meta = {
    hostname = lib.mkOption { type = lib.types.str; };
    description = lib.mkOption { type = lib.types.str; };
  };

  imports = [
    ./disko.nix
    ./facter
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./persist.nix
    ./polkit.nix
    ./systemd-boot.nix
  ];

  config = {
    system.stateVersion = "25.11";
  };
}
