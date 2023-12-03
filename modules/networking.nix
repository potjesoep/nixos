{ lib, pkgs, ...}:

{
  # Enable networking and bluetooth
  networking = {
    networkmanager.enable = true;
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    useDHCP = lib.mkDefault true;
    # interfaces.wlp1s0.useDHCP = lib.mkDefault true;
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Add bluetooth audio codec support
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
    '';
  };

  # Enable avahi with .local domain name resolution
  services.avahi = {
    enable = true;
    # doesn't work for some reason, see below for ipv4 only which does work
    #nssmdns = true;
    openFirewall = true;
  };
  system.nssModules = pkgs.lib.optional true pkgs.nssmdns;
  system.nssDatabases.hosts = pkgs.lib.optionals true (pkgs.lib.mkMerge [
    (pkgs.lib.mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
    (pkgs.lib.mkAfter [ "mdns4" ]) # after dns
  ]);
}
