{ config, lib, ... }:
{
  options.profiles.dev.git = {
    username = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf config.profiles.dev.enable {
    home-manager.sharedModules = [
      {
        programs.git = {
          enable = true;
          settings = {
            user.name = config.profiles.dev.git.username;
            user.email = config.profiles.dev.git.email;
            pull.rebase = false;
            pull.ff = "only";
            gpg.ssh.defaultKeyCommand = "ssh-add -L | awk '{print $2}' | head -n1";
          };
          signing = {
            format = "ssh";
            signByDefault = true;
          };
        };
      }
    ];
  };

  imports = [ ./tui ];
}
