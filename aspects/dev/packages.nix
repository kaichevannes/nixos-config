{
  homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rustup
      ];
    };
}
