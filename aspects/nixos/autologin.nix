{
  nixos =
    { ... }:
    {
      services.getty.autologinOnce = true;
    };
}
