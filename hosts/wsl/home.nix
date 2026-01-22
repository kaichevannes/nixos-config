{ pkgs, lib, ... }:
{
  imports = [
    ./settings.nix
    ../../programs/shared.nix
    ./bash.nix
  ];

  home.username = "cheva";
  home.homeDirectory = "/home/cheva";

  home.packages = with pkgs; [
    xclip
  ];

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    WIN_HOME="/mnt/c/Users/$(whoami)"
    cp "${builtins.toString ./wezterm.lua}" "$WIN_HOME/.wezterm.lua"
  '';
}
