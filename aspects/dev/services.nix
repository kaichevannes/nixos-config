{
  nixos = import ../../services/proton-ssh/nixos.nix;
  homeManager = import ../../services/proton-ssh/homeManager.nix;
}
