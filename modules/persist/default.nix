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
    userDirectories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "Downloads"
        "Projects"
        "iso"
        ".mozilla"
        ".local/share/proton-pass-cli"
        ".local/share/keyrings"
        ".local/share/zoxide"
      ];
      description = "User directories to persist.";
    };
    userFiles = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        ".zsh_history"
        ".local/share/helix/trusted_workspaces"
        ".local/share/helix/excluded_workspaces"
      ];
      description = "User files to persist.";
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
        directories = config.modules.persist.userDirectories;
        files = config.modules.persist.userFiles;
      };
    };
  };
}
