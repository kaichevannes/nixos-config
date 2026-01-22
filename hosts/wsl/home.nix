{ pkgs, lib, ... }:
{
  imports = [
    ./variables.nix
    ../../programs/shared.nix
    ./bash.nix
  ];

  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = {
      git = {
        name = "Kai Chevannes";
        email = "chevannes.kai@gmail.com";
      };
    };
  };

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
