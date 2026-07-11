{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.firefox.enable = lib.mkEnableOption "Enable firefox";

  config.stylix.targets.firefox.profileNames = [ "default" ];
  config.programs.firefox = lib.mkIf config.features.home-manager.firefox.enable {
    enable = true;

    languagePacks = ["en-IN"];

    profiles.default = {
      settings = {
        "browser.urlbar.suggest.searches" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "sidebar.verticalTabs" = true;
      };
    };

    policies = {
      AppAutoUpdate = false;
      NewTabPage = false;
      BackgroundAppUpdate = false;
      DisplayMenuBar = "never";
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      DisableSetDesktopBackground = true;
      DisableProfileImport = true;
      AutofillAddressEnabled = false;
      OfferToSaveLogins = false;
      HardwareAcceleration = true;
      SkipTermsOfUse = true;
      GenerativeAI.Enabled = false;
      FirefoxHome = {
        SponsoredTopSites = false;
        Highlights = false;
        SponsoredHighlights = false;
        SponsoredStories = false;
      };
      UserMessaging = {
        FeatureRecommendations = false;
        ExtensionRecommendations = false;
        UrlBarInterventions = false;
        FirefoxLabs = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
      };
    };
  };
}
