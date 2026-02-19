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

  boot.initrd.availableKernelModules = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
