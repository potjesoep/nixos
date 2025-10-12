{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # email
    electron-mail
    protonmail-bridge-gui
    thunderbird
    tutanota-desktop
    # sync
    syncthingtray
    nextcloud-client
    # browsers
    mullvad-browser
    # social
    (pkgs.gajim.override {
      enableJingle = true;
      enableE2E = true;
      enableSecrets = true;
      enableRST = true;
      enableSpelling = true;
      enableUPnP = true;
      enableAppIndicator = true;
    })
    element-desktop
    fluffychat
    signal-desktop
    telegram-desktop
    zapzap
    zoom-us
  ];
}
