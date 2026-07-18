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

  features.home-manager = {
    foot.enable = false;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    niri.enable = true;
    cli.enable = true;
    ghostty.enable = true;
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
