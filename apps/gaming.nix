{ pkgs, inputs, ... }:

{
  # add NUR overlay for tetrio-plus
  nixpkgs.overlays = [ inputs.nur.overlays.default ];

  environment.systemPackages = with pkgs; [
    # switch
    fusee-nano
    # 3ds
    azahar
    ctrtool
    cutentr
    # wii (u)
    cdecrypt
    cemu
    dolphin-emu
    # ps4
    shadps4-qtlauncher
    # minecraft
    mcaselector
    prismlauncher
    inputs.bedrockonlinux.packages.${pkgs.stdenv.system}.default
    # misc
    (tetrio-desktop.override {
      #tetrio-plus = nur.repos.juxgd.tetrio-plus;
      withTetrioPlus = true;
    })
    apotris
    goverlay
    heroic
    itch
    lutris
    mangohud
    protonup-qt
    r2modman
    xonotic
  ];

  # enable wayland and anti lag for proton globally
  environment.variables = {
    "ENABLE_LAYER_MESA_ANTI_LAG" = "1";
    "PROTON_ENABLE_WAYLAND" = "1";
  };

  # enable ns-usbloader and its udev rules
  programs.ns-usbloader.enable = true;

  # enable gamemode and gamescope
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # udev rules for 8bitdo controllers
  services.udev.extraRules = ''
    # 8BitDo Ultimate Bluetooth Controller's boot HID interface (seems to be shared by multiple 8BitDo devices)
    # Change it only if lsusb prints different Product ID when device is in bootloader mode.
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3208", ATTRS{idVendor}=="2dc8", TAG+="uaccess"

    # 8BitDo Ultimate Bluetooth Controller receiver's HID interface (exposed when the controller is not connected)
    # When it is exposed, the upgrade tool can detect the receiver and automatically put in in bootloader mode.
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3109", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
  '';

  # enable steam and settings
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraPkgs = pkgs': with pkgs'; [
        libvdpau
        libxtst
      ];
    };
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    # open steam ports
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;

  # monado vr runtime
  services.monado = {
    enable = true;
    highPriority = true;
    defaultruntime =  true;
  };
  # vr environment variables
  environment.variables = {
    "PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES" = "1";
    "STEAMVR_MOTION_AMD" = "1";
    "STEAMVR_LH_ENABLE" = "true";
  };

}
