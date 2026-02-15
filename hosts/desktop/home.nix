{ config, ... }:
{
  imports = [
    ./settings.nix
    ../../programs
  ];

  home.homeDirectory = "/home/" + config.var.username;
}
