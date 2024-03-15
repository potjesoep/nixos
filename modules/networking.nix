{ lib, pkgs, ...}:

{
  # Enable networking and bluetooth
  networking = {
    networkmanager.enable = true;
    # Enables DHCP on each ethernet and wireless interface.
    useDHCP = lib.mkDefault true;
    # ports for nicotine-plus/soulseek
    firewall.allowedTCPPorts = [ 2234 2235 2236 2237 2238 2239 42000 42001 ];
    firewall.allowedUDPPorts = [ 8001 ];
  };
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Add bluetooth audio codec support
  #environment.etc = {
  #  "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #      bluez_monitor.properties = {
  #        ["bluez5.enable-sbc-xq"] = true,
  #        ["bluez5.enable-msbc"] = true,
  #        ["bluez5.enable-hw-volume"] = true,
  #        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
  #      }
  #  '';
  #};

  # Enable avahi with .local domain name resolution
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable syncthing
  services.syncthing = {
    enable = true;
    user = "cuddles";
    configDir = "/home/cuddles/.config/syncthing"; # Folder for Syncthing's settings and keys
    dataDir = "/home/cuddles/.config/syncthing/db"; # Folder for Syncthing's database
    openDefaultPorts = true;
  };
}
