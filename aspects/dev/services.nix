{
  nixos = import ../../services/ssh/nixos.nix;
  homeManager = import ../../services/ssh/homeManager.nix;
}
