{
  homeManager =
    { ... }:
    {
      programs.lazygit = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          git.overrideGpg = true;
          customCommands = import ./custom_commands.nix;
        };
      };
    };
}
