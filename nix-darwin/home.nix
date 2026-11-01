{ inputs, lib, config, pkgs, ... }:

{
  home = {
    username = "kuruzyy";
    homeDirectory = "/Users/kuruzyy";
    stateVersion = "26.05";
  };

  home.packages = with pkgs; [
    # Coding / Work
    opentofu
    ansible
    opencode
    uv
    typst
    devenv
    direnv
    git
    lazygit
    quarto

    # Personal / Finance
    hledger
    puffin
    ticker
    zk
    
    # Networking
    curl
    wget
    aria2
    posting
    mkcert
    sing-box

    # System / Terminal
    zip
    unzip
    p7zip
    rclone
    ripgrep
    btop
    bat
    mc
    eza
    fd
    fzf
    jq
    yq
    tmux
    zoxide
    starship

    # Multimedia
    ffmpeg
    gallery-dl
    yt-dlp
  ];
}
