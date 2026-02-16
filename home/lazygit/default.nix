{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
      customCommands = import ./custom_commands.nix;
    };
  };
}
