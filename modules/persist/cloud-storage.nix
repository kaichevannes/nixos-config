{ config, lib, ... }:
{
  config = lib.mkIf config.modules.user.enable {
    modules.secrets.enable = true;

    sops.secrets = {
      "restic/password" = { };
      "restic/r2-env" = { };
    };

    services.restic.backups.personal =
      let
        username = config.meta.username;

        cloudDirectories = list: map (item: item.directory) (lib.filter (item: item.cloudSync) list);
        cloudFiles = list: map (item: item.file) (lib.filter (item: item.cloudSync) list);

        cloudSyncPaths =
          cloudFiles config.modules.persist.systemFiles
          ++ cloudDirectories config.modules.persist.systemDirectories
          ++ map (path: "/home/${username}/${path}") (cloudFiles config.modules.persist.homeFiles)
          ++ map (path: "/home/${username}/${path}") (
            cloudDirectories config.modules.persist.homeDirectories
          );
      in
      {
        repository = "s3:https://ddd66280f8d373a97fa4ba2ff541b0c9.r2.cloudflarestorage.com/personal";
        passwordFile = config.sops.secrets."restic/password".path;
        environmentFile = config.sops.secrets."restic/r2-env".path;

        initialize = true;

        paths = cloudSyncPaths;

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 12"
        ];

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
  };
}
