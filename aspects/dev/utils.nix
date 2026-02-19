{
  homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fzf
        ripgrep
        tokei
      ];
    };
}
