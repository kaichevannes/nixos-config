{ config, lib, ... }:
lib.mkIf config.profiles.dev.enable {
  home-manager.sharedModules = [
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = config.profiles.dev.gitUsername;
          user.email = config.profiles.dev.gitEmail;
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
}
