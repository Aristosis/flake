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
      greasemonkey =
        [
          (pkgs.fetchurl { url = "https://update.greasyfork.org/scripts/459541/YouTube%E5%8E%BB%E5%B9%BF%E5%91%8A.user.js"; hash = "sha256-l1jSu6wD8/77wf5TT9apxvy+6B+9ywVm6pmMkhM6Ex8="; })
        ];
    };
  };
}
