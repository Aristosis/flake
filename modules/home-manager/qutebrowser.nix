{
  config,
  lib,
  pkgs,
  ...
}: let
  mkIf = lib.mkIf;
in {
  options.features.home-manager.qutebrowser.enable = lib.mkEnableOption "Enable qutebrowser configuration";

  config = mkIf config.features.home-manager.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
      enableDefaultBindings = true;
      loadAutoconfig = false;
    };
  };
}
