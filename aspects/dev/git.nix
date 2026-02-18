{
  homeManager =
    { config, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = "Kai Chevannes";
          user.email = "chevannes.kai@gmail.com";
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
