{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./cloud-storage.nix
    ./erase-disk.nix
  ];

  options.modules.persist =
    let
      pathModule = lib.types.submodule {
        options = {
          path = lib.mkOption {
            type = lib.types.str;
            description = "The path to persist.";
          };
          cloudBucket = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "The bucket to backup this data to.";
          };
        };
      };
    in
    {
      systemDirectories = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            path = str;
            cloudBucket = null;
          }) pathModule
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
            path = str;
            cloudBucket = null;
          }) pathModule
        );
        default = [ "/etc/machine-id" ];
        description = "System files to persist.";
      };
      homeDirectories = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            path = str;
            cloudBucket = null;
          }) pathModule
        );
        default = [ ];
        description = "Home directories to persist, with optional cloud sync.";
      };
      homeFiles = lib.mkOption {
        type = lib.types.listOf (
          lib.types.coercedTo lib.types.str (str: {
            path = str;
            cloudBucket = null;
          }) pathModule
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
      directories = map (item: item.path) config.modules.persist.systemDirectories;
      files = map (item: item.path) config.modules.persist.systemFiles;
      users.${config.meta.username} = {
        directories = map (item: item.path) config.modules.persist.homeDirectories;
        files = map (item: item.path) config.modules.persist.homeFiles;
      };
    };
  };
}
