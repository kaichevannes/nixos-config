{
  nixos =
    { pkgs, ... }:
    {
      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;

        # Silent boot
        initrd.systemd.enable = true;
        consoleLogLevel = 0;
        kernelParams = [
          "quiet"
        ];
      };
    };
}
