{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.modules.persist = {
    systemDirectories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "/root/.cache/nix"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/etc/nixos"
      ];
      description = "System directories to persist.";
    };
    systemFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "/etc/machine-id" ];
      description = "System files to persist.";
    };
    homeDirectories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Home directories to persist.";
    };
    homeFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Home files to persist.";
    };
  };

  config = {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = config.modules.persist.systemDirectories;
      files = config.modules.persist.systemFiles;
      users.${config.meta.username} = {
        directories = config.modules.persist.homeDirectories;
        files = config.modules.persist.homeFiles;
      };
    };
  };
}
