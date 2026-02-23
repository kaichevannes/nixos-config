{
  nixos =
    { ... }:
    {
      hardware.graphics = {
        enable = true;
      };

      hardware.nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
      };
    };
}
