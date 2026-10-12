{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # email
    birdtray
    electron-mail
    #protonmail-bridge-gui
    thunderbird
    tutanota-desktop
    # sync
    syncthingtray
    nextcloud-client
    # browsers
    (pkgs.ungoogled-chromium.override {
      enableWideVine = true;
    })
    mullvad-browser
    # social
    (pkgs.gajim.override {
      enableJingle = true;
      enableSecrets = true;
      enableRST = true;
      enableSpelling = true;
      enableUPnP = true;
      enableAppIndicator = true;
    })
    (pkgs.discord.override {
      disableUpdates = true;
      withOpenASAR = true;
      withTTS = true;
      withVencord = true;
    })
    element-desktop
    fluffychat
    signal-desktop
    telegram-desktop
    zapzap
    zoom-us
  ];
}
