{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # programming
    android-tools
    devenv
    dos2unix
    ghostscript
    git-lfs
    grc
    guile
    javaPackages.compiler.temurin-bin.jdk-25
    python3
  ];

  # reverse engineering is sorta like programming
  programs.ghidra.enable = true;
}
