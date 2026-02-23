{
  nixos =
    { ... }:
    {
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
