{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./settings.nix
    ./bash.nix
  ];

  programs.home-manager.enable = true;

  home.username = config.var.username;
  home.homeDirectory = "/home/" + config.var.username;

  home.packages = with pkgs; [
    xclip
  ];

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    WIN_HOME="/mnt/c/Users/$(whoami)"
    cp "${builtins.toString ./wezterm.lua}" "$WIN_HOME/.wezterm.lua"
  '';

  home.stateVersion = "25.05";
}
