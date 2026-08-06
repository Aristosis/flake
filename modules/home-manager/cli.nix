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
      fd
      lazygit
      ripgrep
      btop
      nix-search-cli
      hyfetch

      nil
      lua-language-server
      neovim
      tree-sitter
    ];
    xdg.configFile.nvim.source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flake/modules/home-manager/config/nvim";

    programs = {
      bat.enable = true;

      fzf.enable = true;
      fzf.enableZshIntegration = true;

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

      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

    };
  };
}
