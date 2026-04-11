{ lib, ... }:
{
  options.meta = {
    hostname = lib.mkOption { type = lib.types.str; };
  };

  imports = [
    ./facter
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./systemd-boot.nix
  ];

  config = {
    system.stateVersion = "25.11";
  };
}
