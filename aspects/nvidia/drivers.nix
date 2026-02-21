{
  nixos =
    { ... }:
    {
      hardware.graphics = {
        enable = true;
      };

      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesettings.enable = true;
        nvidiaSettings = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
      };

      boot.blacklistedKernelModules = [ "nouveau" ];
    };
}
