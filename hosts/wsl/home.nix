{ pkgs, lib, ... }: {
  imports = [
    ../../home/shared.nix
    ./bash.nix
  ];

  home.username = "cheva";
  home.homeDirectory = "/home/cheva";

  home.packages = with pkgs; [
    xclip
  ];

  home.file = {
    ".ssh/known_hosts".source = ./known_hosts;
  };

  home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ "$(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip')" ]; then
        WIN_HOME="/mnt/c/Users/$(whoami)"
        if [ -d "$WIN_HOME" ]; then
          cp "$HOME/nixos-config/hosts/wsl/wezterm.lua" "$WIN_HOME/.wezterm.lua"
        fi
      fi
  '';
}
