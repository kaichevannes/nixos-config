{ ... }:
{
  programs.foot = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      main = {
        include = ./sleepyhollow.ini;
      };
    };
  };
}
