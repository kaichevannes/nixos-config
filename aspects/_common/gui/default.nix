{ requires, ... }:
{
  imports =
    requires [
      "user"
      "secrets"
    ]
    ++ [
      ./foot.nix
      ./greetd.nix
      ./hyprland.nix
      ./vicinae.nix
    ];
}
