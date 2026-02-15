{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-material-transparent";
      editor = {
        true-color = true;
        mouse = false;
        line-number = "relative";
        auto-pairs = false;
        rulers = [ 80 ];
      };
      keys = import ./keys.nix;
    };
    languages = import ./languages.nix;
    themes = import ./themes.nix;
  };
}
