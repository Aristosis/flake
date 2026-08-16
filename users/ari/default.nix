{
  inputs,
  config,
  osConfig,
  pkgs,
  ...
}: {
  imports = builtins.attrValues (import ../../modules/home-manager);

  home = rec {
    username = "ari";
    homeDirectory = "/home/ari";
    packages = with pkgs; [
      material-cursors
      thunar
      pavucontrol
    ];

    pointerCursor.enable = true;

    stateVersion = "26.05";
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.xdg.userDirs.music}";
    dbFile = "${config.xdg.userDirs.music}/mpd_db";
  };

  programs = {
    mpv.enable = true;
    rmpc.enable = true;
    foot = {
      enable = true;
      server.enable = true;
    };
  };

  xdg.userDirs = let
    home = "${config.home.homeDirectory}";
    media = "${home}/Media";
  in {
    enable = true;
    createDirectories = true;

    desktop = "${home}/Desktop"; # Default for reference
    documents = "${media}/Documents";
    templates = "${media}/Documents/Templates";
    music = "${media}/Music";
    pictures = "${media}/Pictures";
    videos = "${media}/Videos";

    publicShare = "${media}/Share";
    download = "${media}/Downloads";
    projects = "${media}/Projects";
  };

  features.home-manager = {
    cli = {
      enable = true;
    };
    firefox.enable = true;
    niri.enable = true;
    umu.enable = true;
  };

}
