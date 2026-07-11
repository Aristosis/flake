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
      inputs.self.overlays.nur
    ];
  };

  home = {
    username = "ari";
    homeDirectory = "/home/ari";
  };

  stylix = {
    overlays.enable = false;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = with pkgs; {
      monospace.package = iosevka;
      monospace.name = "Iosevka";
      serif.package = inter;
      serif.name = "Inter";
      sansSerif.package = inter;
      sansSerif.name = "Inter";
      sizes.applications = 12;
      sizes.terminal = 14;
      sizes.desktop = 13;
      sizes.popups = 14;
    };
    opacity = {
      terminal = 0.9;
      popups = 0.9;
    };
    polarity = "dark";
  };

  features.home-manager = {
    foot.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    waybar.enable = true;
    fuzzel.enable = true;
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
      cudaSupport = config.features.graphicsDrivers.nvidia.enable;
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

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
