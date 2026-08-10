{
  lib,
  config,
  pkgs,
  ...
}:
{

  options.features.home-manager.cli.misc.enable = lib.mkOption {
    description = "Enable miscellaneous cli packages";
    default = config.features.home-manager.cli.enable;
  };

  config = lib.mkIf config.features.home-manager.cli.misc.enable {

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

    };

    home.packages = with pkgs; [
      bc
      btop
      duf
      fastfetch
      fd
      nix-search-cli
      p7zip
      ripgrep
    ] ++ lib.optionals config.features.home-manager.cli.git.enable [
    pkgs.lazygit
    ];

  };
}
