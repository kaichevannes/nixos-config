{
  homeManager =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
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
