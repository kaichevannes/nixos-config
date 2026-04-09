{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "install";
  runtimeInputs = with pkgs; [
    git
    nixos-facter
    proton-pass-cli
    ssh-to-age
    disko
    nixos-install-tools
  ];
  text = ''
    readonly HOST="''${1:?Usage: ...#install -- <hostname>}"

    echo "Partitioning disk with disko"
    disko --flake "github:kaichevannes/nixos-config#$HOST" --mode destroy,format,mount

    echo "Cloning config"
    git clone "https://github.com/kaichevannes/nixos-config.git" "/mnt/persist/etc/nixos"
    git -C "/mnt/persist/etc/nixos" remote set-url origin "git@github.com:kaichevannes/nixos-config.git"

    echo "Initialising facter.json"
    nixos-facter -o "/mnt/persist/etc/nixos/hosts/$HOST/facter.json"
    git -C "/mnt/persist/etc/nixos" add "hosts/$HOST/facter.json" "hosts/$HOST/filesystem.nix"

    echo "Initialising age key"
    echo "Log into Proton Pass:"
    mkdir -p "/mnt/persist/var/lib/sops-nix"
    pass-cli test 2>/dev/null && pass-cli logout
    until pass-cli login --interactive; do
      echo "Login failed, try again"
    done
    pass-cli item view \
      --vault-name Keys \
      --item-title id_ed25519 \
      --field private_key \
      | ssh-to-age -private-key -i - > "/mnt/persist/var/lib/sops-nix/key.txt"
    chmod 400 "/mnt/persist/var/lib/sops-nix/key.txt"

    echo "Installing NixOS"
    nixos-install --flake "git+file:///mnt/persist/etc/nixos#$HOST" --no-root-passwd
  '';
}
