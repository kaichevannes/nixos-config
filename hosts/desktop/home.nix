{ config, ... }:
{
  imports = [
    ./settings.nix
    ../../programs/shared.nix
  ];

  home.homeDirectory = "/home/" + config.var.username;
}
