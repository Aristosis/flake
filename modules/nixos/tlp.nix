{
  config,
  lib,
  ...
}:
{
  options.features.tlp.enable = lib.mkEnableOption "Enable TLP power management";

  config = lib.mkIf config.features.tlp.enable {
    services.tlp = {
      enable = true;
    };
  };
}
