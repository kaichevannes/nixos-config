{
  nixos =
    { user, ... }:
    {
      services.getty.autologinUser = user;
    };
}
