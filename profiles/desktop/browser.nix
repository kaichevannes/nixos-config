{ config, lib, ... }:
lib.mkIf config.profiles.desktop.enable {
  modules.persist.homeDirectories = [
    ".config/mozilla"
    "Downloads"
  ];

  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        programs.chromium.enable = true;

        programs.firefox = {
          enable = true;
          configPath = "${config.xdg.configHome}/mozilla/firefox";
          profiles.default.id = 0;
          profiles.llm = {
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
          profiles.whatsapp = {
            id = 2;
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
    )
  ];
}
