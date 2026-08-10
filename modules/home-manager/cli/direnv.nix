{
  lib,
  config,
  pkgs,
  ...
}:
{

  options.features.home-manager.cli.direnv.enable = lib.mkOption {
    description = "Enable direnv configuration";
    default = config.features.home-manager.cli.enable;
  };

  config = lib.mkIf config.features.home-manager.cli.direnv.enable {
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
