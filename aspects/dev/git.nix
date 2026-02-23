{
  homeManager =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          pull.rebase = false;
          pull.ff = "only";
          gpg.ssh.defaultKeyCommand = "ssh-add -L | awk '{print $2}' | head -n1";
        };
        signing = {
          format = "ssh";
          signByDefault = true;
        };
      };
    };
}
