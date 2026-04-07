# Referencing https://github.com/NixOS/nixpkgs/blob/68d8aa3d661f0e6bd5862291b5bb263b2a6595c9/nixos/modules/hardware/facter/graphics/amd.nix
{ lib, config, ... }:
let
  collectDrivers = list: lib.foldl' (lst: value: lst ++ value.driver_modules or [ ]) [ ] list;
  cfg = config.hardware.facter.detected.graphics.nvidia;
in
{
  options.hardware.facter.detected.graphics = {
    nvidia.enable = lib.mkEnableOption "Enable the nvidia graphics module" // {
      default = builtins.elem "nvidia" (
        collectDrivers (config.hardware.facter.report.hardware.graphics_card or [ ])
      );
      defaultText = "hardware dependent";
    };
  };

  config = lib.mkIf (config.hardware.facter.enable && cfg.enable) {
    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
    };
  };
}
