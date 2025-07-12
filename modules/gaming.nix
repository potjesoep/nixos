{ pkgs, ... }:

{
  users.users.cuddles.packages = with pkgs; [
    # gaming
    (pkgs.tetrio-desktop.override {
      withTetrioPlus = true;
    })
    itch
    bottles
    fusee-interfacee-tk
    gamemode
    gamescope
    goverlay
    heroic
    linux-wifi-hotspot
    lutris
    mangohud
    minetest
    mono
    oversteer
    prismlauncher
    protontricks
    protonup-qt
    r2modman
    steamtinkerlaunch
    urbanterror
    vintagestory
    vkbasalt
    wineWowPackages.stagingFull
    winetricks
    xonotic
    (pkgs.callPackage ../pkgs/krisp-patch {})
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    vesktop
  ];


  # steamtinkerlaunch deps
  environment.systemPackages = with pkgs; [
    xdotool
    xorg.xhost
    xorg.xwininfo
    xxd
    yad
  ];

  # Install steam with firewall rules
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
