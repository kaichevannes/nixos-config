{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./art.nix
    ./browser.nix
    ./music
    ./printing.nix
    ./screenshot.nix
    ./vms
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf config.profiles.desktop.enable {
    modules.user.enable = true;
    modules.gui.enable = true;

    environment.systemPackages = with pkgs; [
      ticktick
    ];
    modules.persist.homeDirectories = [ ".config/ticktick" ];

    modules.gui.wm.applications = {
      browser = {
        workspace = 2;
        command = "firefox -P default";
        keybindings = [ "$mod, B" ];
      };
      alt-browser = {
        command = "chromium";
        keybindings = [ "$mod+Shift, B" ];
      };
      task-management = {
        workspace = 5;
        command = "ticktick";
      };
      llm = {
        floating = true;
        command = "firefox --no-remote -P llm --new-window https://claude.ai";
        keybindings = [
          "$mod, A"
          "Alt, A"
        ];
      };
      whatsapp = {
        floating = true;
        command = "firefox --no-remote -P whatsapp --new-window https://web.whatsapp.com/";
        keybindings = [ "$mod, W" ];
      };
    };
  };
}
