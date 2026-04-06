{ config, ... }:
let
  inherit (config.meta) username;
in
{
  DankMonoNerdFont-Regular = {
    owner = username;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Regular.otf.sops;
    path = "/home/${username}/.local/share/fonts/DankMonoNerdFont-Regular.otf";
  };

  DankMonoNerdFont-Italic = {
    owner = username;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Italic.otf.sops;
    path = "/home/${username}/.local/share/fonts/DankMonoNerdFont-Italic.otf";
  };

  DankMonoNerdFont-Bold = {
    owner = username;
    format = "binary";
    sopsFile = ./DankMonoNerdFont-Bold.otf.sops;
    path = "/home/${username}/.local/share/fonts/DankMonoNerdFont-Bold.otf";
  };
}
