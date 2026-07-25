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
    share = "${home}/Share";
  in
  {
    createDirectories = true;

    desktop   = "${home}/Desktop"; # Default for reference
    documents = "${media}/Documents";
    templates = "${media}/Documents/Templates";
    music     = "${media}/Music";
    pictures  = "${media}/Pictures";
    videos    = "${media}/Videos";

    share     = "${share}";
    downloads = "${share}/Downloads";
    projects  = "${share}/Projects";
  };

  features.home-manager = {
    foot.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    niri.enable = true;
    cli.enable = true;
    ghostty.enable = false;
    opencode.enable = true;
    music.enable = true;
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
