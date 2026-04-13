{ config, ... }:
{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      # Logs
      "/var/log"

      # Necessary system state
      "/var/lib/nixos"
      "/var/lib/systemd"

      # Nix config
      {
        directory = "/etc/nixos";
        user = config.meta.username;
        group = config.users.users.${config.meta.username}.group;
      }
    ];
    files = [
      # Necessary system state
      "/etc/machine-id"
    ];
    users.${config.meta.username} = {
      directories = [
        "Downloads"
        "Projects"
        "iso"
      ];
    };
  };

  # https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes
  boot.initrd.systemd.services.wipe-root = {
    description = "Wipe BTRFS root subvolume on boot";
    wantedBy = [ "initrd.target" ];
    after = [ "sysroot.mount" ];
    before = [ "initrd-root-fs.target" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /btrfs_tmp
      mount /dev/disk/by-partlabel/disk-main-root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi
      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }
      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done
      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };
}
