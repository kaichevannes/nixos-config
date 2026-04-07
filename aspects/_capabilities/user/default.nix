{ lib, requires, ... }:
{
  options.meta = {
    username = lib.mkOption { type = lib.types.str; };
  };

  imports = requires [ "secrets" ] ++ [
    ./home-manager.nix
    ./user.nix
  ];
}
