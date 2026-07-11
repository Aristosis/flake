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

  programs = {
    bat.enable = true;

    git = {
      enable = true;
      settings = {
        user.name = "Ari";
        user.email = "communeofstars@proton.me";
        credential.helper = "store";
        init.defaultBranch = "main";
      };
    };
  };

  home.packages = with pkgs; [
    material-cursors
    xwayland-satellite
    thunar

    pavucontrol

    (obs-studio.override {
      cudaSupport = nixosConfig.features.graphicsDrivers.nvidia.enable;
    })
    (prismlauncher.override {
      additionalLibs = with pkgs; [libxt libxtst libxkbcommon];
    })

    # CLI
    nvtopPackages.nvidia
    tree-sitter
    btop
    awww
    neovim
    fastfetch
    wl-clipboard
    cliphist
    manix
    nix-search-cli
    ripgrep

    # Dev.
    nil
    temurin-jre-bin-17
    bc
  ];

  home.stateVersion = "26.05";
}
