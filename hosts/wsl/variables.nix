{ lib, ... }:
{
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = {
      git = {
        name = "Kai Chevannes";
        email = "chevannes.kai@gmail.com";
      };
    };
  };
}
