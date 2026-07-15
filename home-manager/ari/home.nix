{
  inputs,
  lib,
  config,
  nixosConfig,
  pkgs,
  ...
}: {
  imports = builtins.attrValues inputs.self.homeManagerModules;
    
  home = {
    username = "ari";
    homeDirectory = "/home/ari";
  };

  features.home-manager = {
    foot.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    niri.enable = true;
    neovim.enable = true;
    cli.enable = true;
  };

  home.packages = with pkgs; [
    material-cursors
    thunar
    pavucontrol

    (obs-studio.override {
      cudaSupport = nixosConfig.features.graphicsDrivers.nvidia.enable;
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
