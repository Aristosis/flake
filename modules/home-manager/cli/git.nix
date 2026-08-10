{
  lib,
  config,
  ...
}:
{

  options.features.home-manager.cli = {
    git.enable = lib.mkOption {
      description = "Enable git configuration";
      default = config.features.home-manager.cli.enable;
    };

    jujutsu.enable = lib.mkOption {
      description = "Enable jujutsu configuration";
      default = config.features.home-manager.cli.git.enable;
    };
  };

  config = {
    programs.git = lib.mkIf config.features.home-manager.cli.git.enable {
      settings = {
        user.name = "Ari";
        user.email = "communeofstars@proton.me";
        credential.helper = "store";
        init.defaultBranch = "main";
      };
    };

    programs.jujutsu = lib.mkIf config.features.home-manager.cli.jujutsu.enable {
      enable = true;
      settings = {
        ui.diff-editor = ":builtin";
        user.name = "Ari";
        user.email = "communeofstars@proton.me";
      };
    };
  };
}
