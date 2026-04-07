{
  imports = [
    # Requires
    ../_capabilities/user
    ../_capabilities/gui

    # Modules
    ./docker.nix
    ./libvirtd.nix
    ./virt-manager.nix
  ];
}
