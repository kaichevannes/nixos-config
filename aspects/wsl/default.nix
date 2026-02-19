{
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
