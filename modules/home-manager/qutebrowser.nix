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
      settings = {
        colors.webpage.darkmode.enabled = true;
        completion.shrink = true;
        tabs = {
          position = "left";
          show = "multiple";
          width = 32;
        };
      };
      greasemonkey =
        [
          (pkgs.fetchurl { url = "https://raw.githubusercontent.com/SysAdminDoc/YoutubeAdblock/refs/heads/main/YoutubeAdblock.user.js"; hash = "sha256-FGHOG/e3DzExL0WSyf/KfdsHNP0EObI1xIWRKQmzxic="; })
        ];
    };
  };
}
