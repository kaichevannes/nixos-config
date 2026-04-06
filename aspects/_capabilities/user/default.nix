{ lib, ... }:
{
  options.meta = {
    username = lib.mkOption { type = lib.types.str; };
  };

  imports = [
    # Capabilities
    ../secrets

    # Modules
    ./home-manager.nix
    ./user.nix
  ];
}
