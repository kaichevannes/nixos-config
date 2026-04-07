{ lib, ... }:
{
  options.meta = {
    username = lib.mkOption { type = lib.types.str; };
  };

  imports = [
    # Requires
    ../secrets

    # Modules
    ./home-manager.nix
    ./user.nix
  ];
}
