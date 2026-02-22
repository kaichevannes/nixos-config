{
  nixos =
    { ... }:
    {
      services.getty.autologinOnce = true;
    };

  homeManager =
    { ... }:
    {
      home.file.".profile" = {
        text = ''
          if uwsm check may-start; then
              exec uwsm start hyprland.desktop
          fi
        '';
        force = true;
      };
    };
}
