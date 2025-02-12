{ lib, ...}:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = lib.mkDefault "euro";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };
  };

  hardware.xpadneo.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.logitech.wireless.enable = true;
}
