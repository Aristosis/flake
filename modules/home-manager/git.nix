{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.git.enable = lib.mkEnableOption "Enable git configuration";

  config = mkIf config.features.home-manager.git.enable {
    programs = {
# VCS / Git
      git = {
        enable = true;
        settings = {
          user.name = "Ari";
          user.email = "communeofstars@proton.me";
          credential.helper = "store";
          init.defaultBranch = "main";
        };
      };
      jujutsu = {
        enable = true;
        settings = {
          ui.diff-editor = ":builtin";
          user.name = "Ari";
          user.email = "communeofstars@proton.me";
        };
      };
    };
  };
}
