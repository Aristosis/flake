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
      fd
      ripgrep
      lazygit
      duf
    ];

    programs = {
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
