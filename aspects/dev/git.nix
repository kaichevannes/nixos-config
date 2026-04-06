{ config, ... }:
{
  home-manager.sharedModules = [
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = config.meta.gitHubUsername;
          user.email = config.meta.gitHubEmail;
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
