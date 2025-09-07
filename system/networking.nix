{ lib, pkgs, ...}:

{
  # Enable networking and bluetooth
  networking = {
    networkmanager.enable = true;
    # Enables DHCP on each ethernet and wireless interface.
    useDHCP = lib.mkDefault true;
    # ports for nicotine-plus/soulseek
    firewall.allowedTCPPorts = [ 2234 2235 2236 2237 2238 2239 42000 42001 17491 9090 ];
    firewall.allowedUDPPorts = [ 8001 ];
  };

  # Enable mullvad vpn service
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  # Enable avahi with .local domain name resolution
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
