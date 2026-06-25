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

  programs = {

    # neovim.enable = true;
  };

  home.packages = with pkgs; [
    foot
    waybar
    fuzzel
    awww
    material-cursors
    xwayland-satellite
    kitty

    firefox
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
    fzf
    fastfetch
    wl-clipboard
    cliphist
    zoxide
    eza
    bat
    manix
    nix-search-cli

    # Dev.
    nil
    temurin-jre-bin-17
  ];

  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.stateVersion = "26.05";
}
