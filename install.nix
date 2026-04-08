{ pkgs, ... }:
{
  packages.install = pkgs.writeShellApplication {
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
      disko --flake "github:kaichevannes/nixos-config#$HOST" --mode disko

      echo "Cloning config"
      git clone "https://github.com/kaichevannes/nixos-config.git" "/mnt/persist/etc/nixos"
      git -C "/mnt/persist/etc/nixos" remote set-url origin "git@github.com:kaichevannes/nixos-config.git"

      echo "Initialising facter.json"
      nixos-facter -o "/mnt/persist/etc/nixos/hosts/$HOST/facter.json"
      git -C "/mnt/persist/etc/nixos" add "hosts/$HOST/facter.json"

      echo "Initialising age key"
      mkdir -p "/mnt/persist/sops/age"
      pass-cli login --interactive
      pass-cli item view \
        --vault-name Keys \
        --item-title id_ed25519 \
        --field private_key \
        | ssh-to-age -private-key -i - > "/mnt/persist/sops/age/keys.txt"
      chmod 400 "/mnt/persist/sops/age/keys.txt"

      echo "Installing NixOS"
      nixos-install --flake "git+file:///mnt/persist/etc/nixos#$HOST" --no-root-passwd
    '';
  };
}
