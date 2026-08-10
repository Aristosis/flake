{
  lib,
  config,
  pkgs,
  ...
}:
{

  options.features.home-manager.cli.neovim.enable = lib.mkOption {
    description = "Enable Neovim configuration";
    default = config.features.home-manager.cli.enable;
  };

  config = lib.mkIf config.features.home-manager.cli.neovim.enable {
    home.packages = with pkgs; [
    neovim
    tree-sitter
    ];
    xdg.configFile.nvim.source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flake/modules/home-manager/config/nvim";
  };
}
