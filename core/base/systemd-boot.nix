{ ... }:
{
  boot = {
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Silent boot
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
    ];
  };
}
