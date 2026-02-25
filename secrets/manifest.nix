{ user, ... }:
{
  DankMono-Regular-Custom = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMono-Regular-Custom.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMono-Regular-Custom.otf";
  };

  DankMono-Italic-Custom = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMono-Italic-Custom.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMono-Italic-Custom.otf";
  };

  DankMono-Bold-Custom = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMono-Bold-Custom.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMono-Bold-Custom.otf";
  };
}
