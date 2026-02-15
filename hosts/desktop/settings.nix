{ lib, ... }:
{
  config.var = {
    hostname = "nixos";
    username = "cheva";
    git = {
      name = "Kai Chevannes";
      email = "chevannes.kai@gmail.com";
    };
  };

  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };
}
