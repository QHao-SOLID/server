{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    hermes-agent.homeManagerModules.default
  ];

  home = {
    username = "kuruzyy";
    homeDirectory = "/Users/kuruzyy";
    stateVersion = "26.05";
  };

  services = {
    hermes-agent = {
      enable = true;
      gateway.enable = true;
    };
  };

  programs = {
    opencode = {
      enable = true;
      agents = { };
      skills = { };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        dashboard-nvim
        nvim-tree-lua
      ];
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "jonathan";
      };
    };
    firefox = {
      enable = true;
      profiles = {
        kuruzyy = {
          id = 0;
          name = "kuruzyy";
          isDefault = true;
          extensions = with pkgs; [
            nur.repos.rycee.firefox-addons.ublock-origin
          	nur.repos.rycee.firefox-addons.sponsorblock
            nur.repos.rycee.firefox-addons.decentraleyes
            nur.repos.rycee.firefox-addons.downthemall
            nur.repos.rycee.firefox-addons.privacy-badger
           	nur.repos.rycee.firefox-addons.single-file
            nur.repos.rycee.firefox-addons.darkreader
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    opentofu
    ansible
    harlequin
    uv
    typst
    devenv
    direnv
    git
    lazygit
    quarto
    hledger
    puffin
    zk
    posting
    mkcert
    sing-box
    curl
    wget
    aria2
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
    pwgen
    nmap
    ffmpeg
    gallery-dl
    yt-dlp
    theharvester
    sherlock

    (python313.withPackages (python-pkgs: with python-pkgs; [
      pandas
      polars
      requests
      statsmodels
      seaborn
      scipy
      scikit-learn
      matplotlib
      lightgbm
      xgboost
      optuna
      tensorflow
      pytorch
      prefect
      beautifulsoup4
      scrapy
      jupyter
      pyyaml
      opencv4Full
      starlette
      playwright
      duckdb
      yfinance
      pandera
      geopy
      sympy
      pymc
      pytest
      manim
      tablib
      librosa
    ]))
  ];
}
