{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ari.colemak.enable = lib.mkEnableOption "Enable colemak keyboard layout";

  config = lib.mkIf config.ari.colemak.enable {
    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
  };
}
