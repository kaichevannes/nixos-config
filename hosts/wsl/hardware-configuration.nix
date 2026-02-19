{
  lib,
  ...
}:
{
  fileSystems."/" = {
    device = "/";
    fsType = "ext4";
  };

  swapDevices = [ ];

  boot.initr.availableKernelModules = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
