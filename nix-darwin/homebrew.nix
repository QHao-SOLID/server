{ config, pkgs, lib, ... }:

{
  # Darwin-level Homebrew configuration
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [ ];
    casks = [
      "zen-browser"
      "obsidian"
      "obs"
      "vlc"
      "audacity"
      "krita"
      "visual-studio-code"
      "zotero"
      "anki"
      "keepassxc"
    ];
  };
}