{
  imports = [
    # Requires
    ../_capabilities/user
    ../_capabilities/secrets

    # Modules
    ./autologin.nix
    ./chromium.nix
    ./firefox.nix
    ./foot.nix
    ./hyprland.nix
    ./vicinae.nix
  ];
}
