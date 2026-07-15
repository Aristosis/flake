{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.cli.enable = lib.mkEnableOption "Enable CLI programs";

  config = mkIf config.features.home-manager.cli.enable {
    home.packages = with pkgs; [
      bc
      duf
      fastfetch
      fd
      lazygit
      nix-search-cli
      ripgrep
      btop
    ];

    programs = {
      bat.enable = true;
      fish = {
        enable = false;
      };
      git = {
        enable = true;
        settings = {
          user.name = "Ari";
          user.email = "communeofstars@proton.me";
          credential.helper = "store";
          init.defaultBranch = "main";
        };
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
        options = ["--cmd cd"];
      };
      eza = {
        enable = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
