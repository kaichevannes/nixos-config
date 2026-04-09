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
    PERSIST_DIR="/mnt/persist"

    if nix eval "github:kaichevannes/nixos-config#nixosConfigurations.$HOST.config.disko.devices" >/dev/null 2>&1; then
      echo "Partitioning disk with disko"
      disko --flake "github:kaichevannes/nixos-config#$HOST" --mode destroy,format,mount
    else
      echo "No disko config found, skipping partitioning"
      PERSIST_DIR=""
    fi

    echo "Cloning config"
    git clone "https://github.com/kaichevannes/nixos-config.git" "$PERSIST_DIR/etc/nixos"
    git -C "$PERSIST_DIR/etc/nixos" remote set-url origin "git@github.com:kaichevannes/nixos-config.git"

    echo "Initialising facter.json"
    nixos-facter -o "$PERSIST_DIR/etc/nixos/hosts/$HOST/facter.json"
    git -C "$PERSIST_DIR/etc/nixos" add "hosts/$HOST/facter.json" "hosts/$HOST/filesystem.nix"

    echo "Initialising age key"
    mkdir -p "$PERSIST_DIR/var/lib/sops-nix"
    pass-cli login --interactive
    pass-cli item view \
      --vault-name Keys \
      --item-title id_ed25519 \
      --field private_key \
      | ssh-to-age -private-key -i - > "$PERSIST_DIR/var/lib/sops-nix/key.txt"
    chmod 400 "$PERSIST_DIR/var/lib/sops-nix/key.txt"

    echo "Installing NixOS"
    nixos-install --flake "git+file://$PERSIST_DIR/etc/nixos#$HOST" --no-root-passwd
  '';
}
