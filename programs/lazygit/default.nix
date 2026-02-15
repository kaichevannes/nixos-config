{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
      customCommands = import ./customCommands.nix;
    };
  };
}
