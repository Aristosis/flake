{
  config,
  lib,
  ...
}:
{
  options.features.zram.enable = lib.mkEnableOption "Enable zram";
  config.zramSwap = lib.mkIf config.features.zram.enable {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };
}
