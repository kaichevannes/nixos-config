{
  imports = [
    # Requires
    ../_capabilities/user
    ../_capabilities/gui

    # Modules
    ./chromium.nix
    ./firefox.nix
  ];
}
