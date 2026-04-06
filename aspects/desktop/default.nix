{
  imports = [
    # Capabilities
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
