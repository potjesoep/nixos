{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    # recording / editing
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        looking-glass-obs
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
        wlrobs
      ];
    })
    kdenlive
    xwaylandvideobridge
    # music
    fooyin
    mpris-scrobbler
    playerctl
    puddletag
    rescrobbled
    spicetify-cli
    spotify
    sublime-music
    # downloading
    lrcget
    nicotine-plus
    qbittorrent
    # pictures
    inkscape
    krita
    # video
    (mpv.override {
      scripts = with mpvScripts; [
        mpris
        quality-menu
        sponsorblock
        thumbfast
        uosc
      ];
    })
    syncplay
    vlc
    ffmpeg-full
  ];
}
