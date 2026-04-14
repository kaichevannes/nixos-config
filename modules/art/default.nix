{ requires, ... }:
{
  imports = requires [ "gui" ] ++ [
    ./krita.nix
    ./opentabletdriver.nix
  ];
}
