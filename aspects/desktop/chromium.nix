{ ... }:
{
  home-manager.sharedModules = [
    {
      programs.chromium = {
        enable = true;
      };
    }
  ];
}
