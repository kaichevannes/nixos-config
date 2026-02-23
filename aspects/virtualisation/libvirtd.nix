{
  nixos =
    { pkgs, user, ... }:
    {
      virtualisation.libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;
        };
      };

      users.groups.libvirtd.members = [ user ];
      users.groups.kvm.members = [ user ];

      environment.systemPackages = with pkgs; [
        dnsmasq
      ];
    };
}
