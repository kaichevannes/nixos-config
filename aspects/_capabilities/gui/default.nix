{ requires, ... }:
{
  imports =
    requires [
      "user"
      "secrets"
    ]
    ++ [
      ./foot.nix
      ./hyprland.nix
      ./vicinae.nix
    ];
}
