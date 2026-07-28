{
  inputs,
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: {
  imports = builtins.attrValues inputs.self.homeManagerModules;

  home = {
    username = "ari";
    homeDirectory = "/home/ari";
  };
  xdg.userDirs =
  let
    home = "${config.home.homeDirectory}";
    media = "${home}/Media";
  in
  {
    enable = true;
    createDirectories = true;

    desktop     = "${home}/Desktop";              # Default for reference
    documents   = "${media}/Documents";
    templates   = "${media}/Documents/Templates";
    music       = "${media}/Music";
    pictures    = "${media}/Pictures";
    videos      = "${media}/Videos";

    publicShare = "${media}/Share";
    download    = "${media}/Downloads";
    projects    = "${media}/Projects";
  };

  features.home-manager = {
    cli.enable = true;
    firefox.enable = true;
    foot.enable = true;
    mpv.enable = true;
    niri.enable = true;
    waybar.enable = true;
    zsh.enable = true;
  };

  home.packages = with pkgs; [
    material-cursors
    thunar
    pavucontrol

    (obs-studio.override {
      cudaSupport = osConfig.features.graphicsDrivers.nvidia.enable;
    })

    (prismlauncher.override {
      additionalLibs = with pkgs; [libxt libxtst libxkbcommon];
    })
    temurin-jre-bin-17

    # Clipboard
    wl-clipboard
    cliphist
  ];

  home.stateVersion = "26.05";
}
