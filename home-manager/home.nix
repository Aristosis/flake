{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = (builtins.attrValues inputs.self.homeManagerModules);

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
  };

  home = {
    username = "ari";
    homeDirectory = "/home/ari";
  };

  ari.home-manager = {
    foot.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    fuzzel.enable = true;
  };

  programs = {

    fzf = {
      colors = {};
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

  };

  home.packages = with pkgs; [
    fuzzel
    awww
    material-cursors
    xwayland-satellite
    kitty

    pavucontrol

    (obs-studio.override { cudaSupport = true; })
    (prismlauncher.override {
      additionalLibs = with pkgs; [ libxt libxtst libxkbcommon ];
    })

    # CLI
    git
    zellij
    btop
    nvtopPackages.nvidia
    neovim
    fastfetch
    wl-clipboard
    cliphist
    bat
    manix
    nix-search-cli

    # Dev.
    nil
    temurin-jre-bin-17
    bc
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.stateVersion = "26.05";
}
