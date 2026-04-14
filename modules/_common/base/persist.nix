{ config, inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  fileSystems."/persist".neededForBoot = true;

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/root/.cache/nix"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/log"
      "/etc/nixos"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${config.meta.username} = {
      directories = [
        "Downloads"
        "Projects"
        "iso"
        ".mozilla"
        {
          directory = ".local/share/proton-pass-cli";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/zoxide"
      ];
      files = [
        ".zsh_history"
        ".local/share/helix/trusted_workspaces"
        ".local/share/helix/excluded_workspaces"
      ];
    };
  };

  # https://github.com/nix-community/impermanence?tab=readme-ov-file#btrfs-subvolumes
  boot.initrd.systemd.services.wipe-root = {
    description = "Wipe BTRFS root subvolume on boot";
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@cryptroot.service" ];
    before = [ "initrd-root-fs.target" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /btrfs_tmp
      mount /dev/mapper/cryptroot /btrfs_tmp
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
