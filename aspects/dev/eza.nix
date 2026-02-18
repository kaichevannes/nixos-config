{
  homeManager =
    { ... }:
    {
      programs.eza = {
        enable = true;
        enableZshIntegration = true;
      };
    };
}
