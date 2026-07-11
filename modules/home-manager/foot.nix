{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.foot.enable = lib.mkEnableOption "Enable foot terminal emulator";

  config.programs.foot = lib.mkIf config.features.home-manager.foot.enable {
    enable = true;
    server.enable = true;
  };
}
