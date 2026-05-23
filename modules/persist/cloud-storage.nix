{ config, lib, ... }:
{
  config = lib.mkIf config.modules.user.enable {
    modules.secrets.enable = true;

    sops.secrets = {
      "restic/password" = { };
      "restic/r2-env" = { };
    };

    services.restic.backups =
      let
        prependHome = map (item: item // { path = "/home/${config.meta.username}/${item.path}"; });

        cloudItems = lib.filter (item: item.cloudBucket != null);
        cloudSyncItems =
          cloudItems config.modules.persist.systemFiles
          ++ cloudItems config.modules.persist.systemDirectories
          ++ prependHome (cloudItems config.modules.persist.homeFiles)
          ++ prependHome (cloudItems config.modules.persist.homeDirectories);

        itemsByBucket = lib.groupBy (item: item.cloudBucket) cloudSyncItems;
      in
      lib.mapAttrs (bucket: items: {
        repository = "s3:https://ddd66280f8d373a97fa4ba2ff541b0c9.r2.cloudflarestorage.com/${bucket}";
        passwordFile = config.sops.secrets."restic/password".path;
        environmentFile = config.sops.secrets."restic/r2-env".path;

        initialize = true;

        paths = map (item: item.path) items;

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 12"
          "--keep-yearly 3"
        ];

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      }) itemsByBucket;

    modules.persist.systemDirectories = [ "/var/lib/restore-markers" ];
    systemd.services =
      let
        buckets = lib.unique (
          lib.filter (bucket: bucket != null) (
            lib.catAttrs "cloudBucket" (
              config.modules.persist.systemFiles
              ++ config.modules.persist.systemDirectories
              ++ config.modules.persist.homeFiles
              ++ config.modules.persist.homeDirectories
            )
          )
        );
      in
      lib.listToAttrs (
        map (
          bucket:
          lib.nameValuePair "restic-restore-${bucket}" {
            description = "Restore ${bucket} from restic if marker is absent.";
            wantedBy = [ "multi-user.target" ];
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];

            unitConfig.ConditionPathExists = "!/var/lib/restore-markers/${bucket}.done";

            serviceConfig = {
              Type = "oneshot";
              RemainAfterExit = true;
            };

            script = ''
              restic-${bucket} restore latest --target /
              touch /var/lib/restore-markers/${bucket}.done
            '';

            path = [ "/run/current-system/sw" ];
          }
        ) buckets
      );
  };
}
