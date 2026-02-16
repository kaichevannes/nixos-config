# nixos-config

## NixOS
1. Clone repo
```
sudo nix-env -iA nixos.git
git clone https://github.com/kaichevannes/nixos-config.git ~/.config/nixos-config
```
2. Move hardware-configuration if necessary
`cp /etc/nixos/hardware-configuration.nix ~/.config/nixos-config/hosts/desktop/`
3. Build system
`sudo nixos-rebuild switch --flake ~/.config/nixos-config#desktop`


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
