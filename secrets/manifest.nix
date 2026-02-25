{ user, ... }:
{
  DankMonoNerdFont-Regular = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Regular.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMonoNerdFont-Regular.otf";
  };

  DankMonoNerdFont-Italic = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Italic.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMonoNerdFont-Italic.otf";
  };

  DankMonoNerdFont-Bold = {
    owner = user;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Bold.otf.sops;
    path = "/home/${user}/.local/share/fonts/DankMonoNerdFont-Bold.otf";
  };
}
