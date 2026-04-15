{ config, lib, ... }:
lib.mkIf config.modules.gui.enable {
  modules.secrets.homeFiles = [
    ".local/share/fonts/DankMonoNerdFont-Regular.otf"
    ".local/share/fonts/DankMonoNerdFont-Italic.otf"
    ".local/share/fonts/DankMonoNerdFont-Bold.otf"
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "DankMono Nerd Font:size=25";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors-dark = {
        alpha = 0.85;
        cursor = "391a02 af9a91";
        foreground = "af9a91";
        background = "121214";
        regular0 = "572100";
        regular1 = "ba3934";
        regular2 = "91773f";
        regular3 = "b55600";
        regular4 = "5f63b4";
        regular5 = "a17c7b";
        regular6 = "8faea9";
        regular7 = "af9a91";
        bright0 = "4e4b61";
        bright1 = "d9443f";
        bright2 = "d6b04e";
        bright3 = "f66813";
        bright4 = "8086ef";
        bright5 = "e2c2bb";
        bright6 = "a4dce7";
        bright7 = "d2c7a9";
        selection-foreground = "d2c7a9";
        selection-background = "575256";
      };
    };
  };
}
