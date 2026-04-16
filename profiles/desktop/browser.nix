{ config, lib, ... }:
lib.mkIf config.profiles.desktop.enable {
  modules.persist.homeDirectories = [ ".mozilla" ];

  home-manager.sharedModules = [
    {
      programs.chromium.enable = true;

      programs.firefox = {
        enable = true;
        profiles.default.id = 0;
        profiles.focumon = {
          id = 1;
          settings = {
            "browser.tabs.inTitlebar" = 1;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #nav-bar { visibility: collapse !important; }
          '';
        };
        profiles.work.id = 2;
        profiles.llm = {
          id = 3;
          settings = {
            "browser.tabs.inTitlebar" = 1;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #nav-bar { visibility: collapse !important; }
          '';
        };
        profiles.whatsapp = {
          id = 4;
          settings = {
            "browser.tabs.inTitlebar" = 1;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #TabsToolbar { visibility: collapse !important; }
            #nav-bar { visibility: collapse !important; }
          '';
        };
      };
    }
  ];
}
