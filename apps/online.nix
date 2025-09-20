{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # email
    electron-mail
    tutanota-desktop
    # sync
    syncthingtray
    nextcloud-client
    # browsers
    (pkgs.ungoogled-chromium.override {
      enableWideVine = true;
    })
    librewolf
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
