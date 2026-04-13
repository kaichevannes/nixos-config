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

    echo "Log into Proton Pass:"
    pass-cli test 2>/dev/null && pass-cli logout
    until pass-cli login --interactive; do
      echo "Login failed, try again"
    done

    echo "Cloning config"
    git clone "https://github.com/kaichevannes/nixos-config.git" "/tmp/nixos-config"
    git -C "/tmp/nixos-config" remote set-url origin "git@github.com:kaichevannes/nixos-config.git"

    echo "Initialising facter.json"
    nixos-facter -o "/tmp/nixos-config/hosts/$HOST/facter.json"
    git -C "/tmp/nixos-config" add "hosts/$HOST/facter.json"

    echo "Initialising LUKS secret key"
    pass-cli item view \
      --vault-name Keys \
      --item-title LUKS \
      --field Note | tr -d '\n' > /tmp/secret.key

    echo "Partitioning disk with disko"
    disko --flake "git+file:///tmp/nixos-config#$HOST" --mode destroy,format,mount

    echo "Moving git repo to /mnt/persist/etc/nixos"
    mkdir -p "/mnt/persist/etc"
    mv "/tmp/nixos-config" "/mnt/persist/etc/nixos"
    chown -R 1000:100 "/mnt/persist/etc/nixos"

    echo "Initialising age key"
    mkdir -p "/mnt/persist/var/lib/sops-nix"
    pass-cli item view \
      --vault-name Keys \
      --item-title id_ed25519 \
      --field private_key \
      | ssh-to-age -private-key -i - > "/mnt/persist/var/lib/sops-nix/key.txt"
    chmod 644 "/mnt/persist/var/lib/sops-nix/key.txt"

    echo "Installing NixOS"
    nixos-install --flake "git+file:///mnt/persist/etc/nixos#$HOST" --no-root-passwd
  '';
}
