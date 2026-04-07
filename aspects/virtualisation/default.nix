{ requires, ... }:
{
  imports =
    requires [
      "user"
      "gui"
    ]
    ++ [
      ./docker.nix
      ./libvirtd.nix
      ./virt-manager.nix
    ];
}
