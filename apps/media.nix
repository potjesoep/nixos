{ pkgs, inputs, ... }:

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
    supersonic
    # downloading
    lrcget
    nicotine-plus
    qbittorrent
    varia
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

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.default;
    enabledExtensions = with spicePkgs.extensions; [
      #fullAppDisplayMod
      #keyboardShortcut
      shuffle
      #powerBar
      #seekSong
      #fullAlbumDate
      #wikify
      #showQueueDuration
      #copyToClipboard
      #betterGenres
      #lastfm
      hidePodcasts
      #volumePercentage
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      historyInSidebar
      #betterLibrary
    ];
    enabledSnippets = with spicePkgs.snippets; [
      hideDownloadButton
      hideAudiobooksButton
      hideFriendActivityButton
      hideLyricsButton
      hideMadeForYou
    ];
  };
}
