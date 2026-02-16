# nixos-config

## NixOS
https://nixos.org/manual/nixos/stable/#sec-installation-manual-partitioning
1. Start root shell
```
sudo -i
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
4. Mount
```
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```
5. Clone repo
```
nix-env -iA nixos.git
git clone https://github.com/kaichevannes/nixos-config.git /mnt/root/nixos-config
```
6. Generate and copy hardware-configuration.nix
```
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/root/nixos-config/hosts/desktop/
```
7. Install system
```
nixos-install --flake /root/nixos-config#nixos
```
8. Set password for user account
```
nixos-enter --root /mnt -c 'passwd cheva'
```
9. Reboot
```
reboot
```

## WSL
Install [Wezterm nightly](https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe)
### Elevated Powershell
1. Install WSL and Nix
```
wsl.exe --install Ubuntu
wsl.exe -d Ubuntu
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
exit
```
2. Install home-manager and initialise dotfiles
```
wsl.exe -d Ubuntu
cd
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
git clone https://github.com/kaichevannes/nixos-config.git ~/.config/nixos-config
home-manager switch --flake ~/.config/nixos-config#wsl
```
3. Initialise SSH key
```
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
