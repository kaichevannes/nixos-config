{ pkgs, lib, ... }: {
  imports = [
    ./variables.nix
    ../../home/shared.nix
    ./bash.nix
  ];

  home.username = "cheva";
  home.homeDirectory = "/home/cheva";

  home.packages = with pkgs; [
    xclip
  ];

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      WIN_HOME="/mnt/c/Users/$(whoami)"
      cp "$HOME/nixos-config/hosts/wsl/wezterm.lua" "$WIN_HOME/.wezterm.lua"
  '';
}
