{
  nixos =
    { collectModulesFromKind, ... }:
    {
      imports = collectModulesFromKind "../../services" "nixos" "ssh";
    };

  homeManager =
    { collectModulesFromKind, ... }:
    {
      imports = collectModulesFromKind "../../services" "homeManager" "ssh";
    };
}
