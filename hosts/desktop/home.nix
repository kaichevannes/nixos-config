{ config, ... }:
{
  imports = [
    ./settings.nix
    ../../home
  ];

  home.homeDirectory = "/home/" + config.var.username;
}
