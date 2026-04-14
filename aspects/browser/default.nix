{ requires, ... }:
{
  imports =
    requires [
      "user"
      "gui"
    ]
    ++ [
      ./chromium.nix
      ./firefox.nix
    ];
}
