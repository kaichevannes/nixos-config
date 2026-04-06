{ ... }:
{
  networking.networkmanager = {
    enable = true;
    dhcp = "dhcpcd";
    dns = "systemd-resolved";
  };
  services.resolved.enable = true;
}
