{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.firefox.enable = lib.mkEnableOption "Enable firefox";

  config.programs.firefox = lib.mkIf config.features.home-manager.firefox.enable {
    enable = true;

    languagePacks = ["en-IN"];

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;

      DisplayMenuBar = "never";
      HardwareAcceleration = true;
      OfferToSaveLogins = false;
    };
  };
}
