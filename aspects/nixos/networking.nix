{
  nixos =
    { hostname, ... }:
    {
      networking.hostName = hostname;
      networking.networkmanager.enable = true;
      networking.networkmanager.dhcp = "dhcpcd";
    };
}
