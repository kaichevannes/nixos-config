{
  nixos =
    { ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };

  homeManager =
    { ... }:
    {
      programs.home-manager.enable = true;
      home.stateVersion = "25.05";
    };
}
