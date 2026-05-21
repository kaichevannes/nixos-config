{
  config,
  inputs,
  lib,
  ...
}:
{
  options.modules.persist =
    let
      fileModule = lib.types.submodule {
        options = {
          file = lib.mkOption {
            type = lib.types.str;
            description = "The file path";
          };
          cloudSync = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to sync this directory to the cloud.";
          };
        };
      };
      dirModule = lib.types.submodule {
        options = {
          directory = lib.mkOption {
            type = lib.types.str;
            description = "The directory path";
          };
          cloudSync = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Whether to sync this directory to the cloud.";
          };
        };
      };
    in
    {
      systemDirectories = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            directory = str;
            cloudSync = false;
          }) dirModule
        );
        default = [
          "/root/.cache/nix"
          "/var/lib/nixos"
          "/var/lib/systemd"
          "/etc/nixos"
        ];
        description = "System directories to persist.";
      };
      systemFiles = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            file = str;
            cloudSync = false;
          }) fileModule
        );
        default = [ "/etc/machine-id" ];
        description = "System files to persist.";
      };
      homeDirectories = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            directory = str;
            cloudSync = false;
          }) dirModule
        );
        default = [ ];
        description = "Home directories to persist, with optional cloud sync.";
      };
      homeFiles = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            file = str;
            cloudSync = false;
          }) fileModule
        );
        default = [ ];
        description = "Home files to persist.";
      };
    };

  config = {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = map (item: item.directory) config.modules.persist.systemDirectories;
      files = map (item: item.file) config.modules.persist.systemFiles;
      users.${config.meta.username} = {
        directories = map (item: item.directory) config.modules.persist.homeDirectories;
        files = map (item: item.file) config.modules.persist.homeFiles;
      };
    };
  };

  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./cloud-storage.nix
    ./erase-disk.nix
  ];
}
