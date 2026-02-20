# nixos-config

## NixOS (Minimal ISO)
https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning
1. Start root shell and uk keyboard layout
```
sudo -i
loadkeys uk
```
2. Partition
```
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart root ext4 512MB -8GB
parted /dev/sda -- mkpart swap linux-swap -8GB 100%
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on
```
3. Format
```
mkfs.ext4 -L nixos /dev/sda1
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
```
4. Mount (include `/by-label/` directly)
```
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```
5. Clone repo
```
nix-shell -p git
git clone https://github.com/kaichevannes/nixos-config.git /mnt/root/nixos-config
```
6. Generate and copy hardware-configuration.nix
```
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/root/nixos-config/hosts/camus/hardware-configuration.nix
git -C /mnt/root/nixos-config add .
```
7. Install system
```
nixos-install --flake /mnt/root/nixos-config#camus
```
8. Set password for user account
```
nixos-enter --root /mnt -c 'passwd cheva'
```
9. Reboot and move repo to home
```
reboot
sudo mv /root/nixos-config ~/.config/nixos-config
sudo chown -R $USER:users ~/.config/nixos-config
```
10. Symlink `flake.nix` to `/etc/nixos/flake.nix`
```
sudo ln -sf ~/.config/nixos-config/flake.nix /etc/nixos/flake.nix`
```

To rebuild use `sudo nixos-rebuild switch`. NixOS rebuilds the current host from `/etc/nixos/flake.nix`. 
To rollback use `sudo nixos-rebuild switch --rollback`.

## WSL
Install [Wezterm nightly](https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe)
### Elevated Powershell

1. Enable WSL
```
wsl.exe --install --no-distribution
```

2. Download and run `nixos.wsl` from [the latest release](https://github.com/nix-community/NixOS-WSL/releases/latest)
3. Initialise system
```
sudo nixos-rebuild boot --flake github:kaichevannes/nixos-config#wsl
```
4. Reset default username
```
exit
wsl.exe -t NixOS
wsl.exe -d NixOS --user root exit
wsl.exe -t NixOS
```
5. Initialise SSH key
```
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
