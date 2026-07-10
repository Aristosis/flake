{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = builtins.attrValues inputs.self.homeManagerModules;

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

  features.home-manager = {
    foot.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    fuzzel.enable = true;
    niri.enable = true;
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
      options = ["--cmd cd"];
    };
  };

  home.packages = with pkgs; [
    material-cursors
    xwayland-satellite

    pavucontrol

    obs-studio
    (prismlauncher.override {
      additionalLibs = with pkgs; [libxt libxtst libxkbcommon];
    })

    # CLI
    btop
    awww
    neovim
    fastfetch
    wl-clipboard
    cliphist
    manix
    nix-search-cli

    # Dev.
    nil
    temurin-jre-bin-17
    bc
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
