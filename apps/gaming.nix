{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # switch
    fusee-nano
    # 3ds
    azahar
    ctrtool
    cutentr
    # minecraft
    mcaselector
    prismlauncher
    # misc
    mangohud
    r2modman
    xonotic
    tetrio-desktop
  ];

  # enable ns-usbloader and its udev rules
  programs.ns-usbloader.enable = true;

  # enable gamemode and gamescope
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  services.udev.extraRules = ''
    # 8BitDo Ultimate Bluetooth Controller's boot HID interface (seems to be shared by multiple 8BitDo devices)
    # Change it only if lsusb prints different Product ID when device is in bootloader mode.
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3208", ATTRS{idVendor}=="2dc8", TAG+="uaccess"

    # 8BitDo Ultimate Bluetooth Controller receiver's HID interface (exposed when the controller is not connected)
    # When it is exposed, the upgrade tool can detect the receiver and automatically put in in bootloader mode.
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3109", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
  '';

  programs.steam.enable = true;
}
