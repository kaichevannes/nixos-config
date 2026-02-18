{
  homeManager =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = config.var.git.name;
          user.email = config.var.git.email;
          pull.rebase = false;
          pull.ff = "only";
        };
        signing = {
          key = "~/.ssh/id_ed25519";
          format = "ssh";
          signByDefault = true;
        };
      };
    };
}
