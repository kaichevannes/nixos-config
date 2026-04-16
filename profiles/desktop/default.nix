{
  config,
  lib,
  ...
}:
{
  imports = [
    ./art.nix
    ./browser.nix
    ./screenshot.nix
    ./vms
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf config.profiles.desktop.enable {
    modules.user.enable = true;
    modules.gui.enable = true;

    modules.gui.wm.applications = {
      browser = {
        workspace = 2;
        command = "firefox -P default";
        keybindings = [ "$mod, B" ];
      };
      work-browser = {
        command = "firefox -P work";
        keybindings = [ "$mod+Shift, B" ];
      };
      focumon = {
        workspace = 5;
        command = "firefox --no-remote -P focumon --new-window https://focumon.com";
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
