{
  security.rtkit.enable = true;
  pipewire = {
    enable = true;
    extraConfig.pipewire."98-crackling-fix".context.properties.default.clock = {
      quantum = 1024;
      min-quantum = 1024;
      max-quantum = 8192;
    };
  };
}
