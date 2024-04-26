{ pkgs, ... }:

{
  users.users.cuddles.packages = with pkgs; [
    # gaming
    (pkgs.tetrio-desktop.override {
      #withTetrioPlus = true;
    })
    #itch
    bottles
    fusee-interfacee-tk
    gamemode
    gamescope
    goverlay
    heroic
    lutris
    mangohud
    minetest
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
