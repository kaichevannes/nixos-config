{ config, inputs, ... }:
let
  facterReport = config.hardware.facter.report;
  firstDisk = builtins.head facterReport.hardware.disk;
  device = builtins.elemAt firstDisk.unix_device_names (
    builtins.length firstDisk.unix_device_names - 1
  );

  memoryBytes =
    (builtins.head (
      builtins.filter (resource: resource.type == "phys_mem")
        (builtins.head facterReport.hardware.memory).resources
    )).range;

  swapSize = "${toString (memoryBytes / (1024 * 1024))}M";
in
{
  imports = [ inputs.disko.nixosModules.disko ];

  # https://github.com/nix-community/disko/blob/master/example/luks-btrfs-subvolumes.nix
  disko.devices = {
    disk.main = {
      type = "disk";
      device = device;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings = {
                allowDiscards = true;
                keyFile = "/tmp/secret.key";
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = swapSize;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
