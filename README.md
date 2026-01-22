# nixos-config

## WSL

### Elevated Powershell

1. Install (Wezterm nightly)[https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe]
2. Install WSl and Nix
```
wsl.exe --install Ubuntu
wsl.exe -d Ubuntu
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
exit
```
3. Install home-manager and initialise dotfiles
```
wsl.exe -d Ubuntu
cd
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
git clone https://github.com/kaichevannes/nixos-config.git
home-manager switch --flake ~/nixos-config#wsl
```
4. Initialise SSH key
```
ssh-keygen
cat ~/.ssh/id_ed25519.pub
```
