{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.profiles.desktop.vms.enable {
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      swtpm.enable = true;
    };
  };

  users.groups.libvirtd.members = [ config.meta.username ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
  systemd.services.libvirt-default-network = {
    description = "Start libvirt default network";
    after = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
      ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
      RemainAfterExit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
}
