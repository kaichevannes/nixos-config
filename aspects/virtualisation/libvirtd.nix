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

      networking.firewall.trustedInterfaces = [ "virbr0" ];
      systemd.services.libvirt-default-network = {
        description = "Start libvirt default network";
        after = [ "libvirtd.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
          ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
          User = "root";
        };
      };

      environment.systemPackages = with pkgs; [
        dnsmasq
      ];
    };
}
