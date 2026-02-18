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

  # temp
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  # temp

  home.username = config.var.username;
  home.homeDirectory = "/home/" + config.var.username;

  home.packages = with pkgs; [
    xclip
  ];

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    WIN_HOME="/mnt/c/Users/$(whoami)"
    cp "${builtins.toString ./wezterm.lua}" "$WIN_HOME/.wezterm.lua"
  '';
}
