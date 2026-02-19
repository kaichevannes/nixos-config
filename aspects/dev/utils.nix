{
  homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ripgrep
        tokei
      ];
    };
}
