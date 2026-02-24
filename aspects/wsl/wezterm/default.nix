{
  homeManager =
    { lib, ... }:
    {
      home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        WIN_HOME="/mnt/c/Users/$(whoami)"
        cp "${builtins.toString ./wezterm.lua}" "$WIN_HOME/.wezterm.lua"
      '';
    };
}
