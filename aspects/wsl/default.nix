{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  options.hardware.facter.detected.virtualisation.wsl =
    lib.mkEnableOption "Enable the WSL virtualisation module"
    // {
      default = config.hardware.facter.report.virtualisation == "wsl";
      defaultText = "environment dependent";
    };

  imports = [ inputs.nixos-wsl.nixosModules.default ];

  config = lib.mkIf config.hardware.facter.detected.virtualisation.wsl {
    wsl.enable = true;
    wsl.defaultUser = config.meta.username;

    home-manager.sharedModules = [
      {
        home.packages = with pkgs; [ xclip ];
        home.activation.copyWeztermConfigToWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          WIN_HOME="/mnt/c/Users/$(whoami)"
          cp "${builtins.toString ./wezterm.lua}" "$WIN_HOME/.wezterm.lua"
        '';
      }
    ];
  };
}
