{ config, lib, ... }:
{
  options.profiles.desktop.printing = {
    enable = lib.mkEnableOption "printing";
  };

  config = lib.mkIf config.profiles.desktop.printing.enable {
    services.printing.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
