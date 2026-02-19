{
  nixos =
    { ... }:
    {
      wsl.defaultUser = "cheva";
      boot.isContainer = true;
      system.stateVersion = "25.11";
    };

  homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        xclip
      ];

      programs.home-manager.enable = true;
      home.stateVersion = "25.05";
    };
}
