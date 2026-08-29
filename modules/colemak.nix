{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.colemak.enable = lib.mkEnableOption "Enable colemak keyboard layout";

  config = lib.mkIf config.features.colemak.enable {
    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
  };
}
