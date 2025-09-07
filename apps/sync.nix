{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthingtray
    nextcloud-client
    calibre
  ];

  # Enable syncthing service
  services.syncthing = {
    enable = true;
    user = "cuddles";
    configDir = "/home/cuddles/.config/syncthing"; # Folder for Syncthing's settings and keys
    dataDir = "/home/cuddles/.config/syncthing/db"; # Folder for Syncthing's database
    openDefaultPorts = true;
  };

  # Enable KDE Connect
  programs.kdeconnect.enable = true;
}
