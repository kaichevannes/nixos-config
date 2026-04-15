{ config, lib, ... }:
lib.mkIf config.profiles.desktop.enable {
  home-manager.sharedModules = [
    {
      programs.firefox = {
        enable = true;
        profiles.default.id = 0;
        profiles.focumon = {
          id = 1;
          settings = {
            "widget.wayland.vsync.enabled" = false;
          };
        };
        profiles.work.id = 2;
        profiles.llm = {
          settings = {
            "browser.tabs.inTitlebar" = 1;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #nav-bar { visibility: collapse !important; }
          '';
          id = 3;
        };
        profiles.whatsapp = {
          settings = {
            "browser.tabs.inTitlebar" = 1;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #nav-bar { visibility: collapse !important; }
          '';
          id = 4;
        };
      };
    }
  ];
}
