{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.librewolf.enable = lib.mkEnableOption "Enable librewolf";

  config.stylix.targets.librewolf.profileNames = ["default"];

  config.programs.librewolf = lib.mkIf config.features.home-manager.librewolf.enable {
    enable = true;

    languagePacks = ["en-IN"];

    profiles.default = {
      settings = {
        # Inspiration taken from https://github.com/yokoffing/Betterfox

        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.ai.control.default" = "blocked";
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.cache.disk.enable" = false;
        "browser.compactmode.show" = true;
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.open_pdf_attachments_inline" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.formfill.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.enable" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.privateWindowSeparation.enabled" = false;
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.profiles.enabled" = true;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.search.update" = false;
        "browser.sessionstore.interval" = 60000;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.uitour.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "content.notify.interval" = 100000;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.usage.uploadEnabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "editor.truncate_user_pastes" = false;
        "extensions.enabledScopes" = 5;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "findbar.highlightAll" = true;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;
        "general.smoothScroll.msdPhysics.enable" = true;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "image.mem.decode_bytes_at_a_time" = 32768;
        "javascript.options.baselinejit.threshold" = 50;
        "media.cache_readahead_limit" = 3600;
        "media.cache_resume_threshold" = 1800;
        "media.memory_cache_max_size" = 65536;
        "mousewheel.default.delta_multipier_y" = true;
        "network.IDN_show_punycode" = true;
        "network.auth.subresource-http-auth-allow" = 1;
        "network.buffer.cache.count" = 48;
        "network.buffer.cache.size" = 65535;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.dnsCacheExpiration" = 3600;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.request.max-start-delay" = 5;
        "network.http.speculative-parallel-limit" = 0;
        "network.prefetch-next" = false;
        "pdfjs.enableScripting" = false;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "permissions.manager.defaultsUrl" = "";
        "privacy.antitracking.isolateContentScriptResources" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.history.custom" = true;
        "privacy.userContext.ui.enabled" = true;
        "security.OCSP.enabled" = 0;
        "security.csp.reporting.enabled" = false;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "security.tls.enable_0rtt_data" = false;
        "sidebar.verticalTabs" = true;
        "signon.formlessCapture.enabled" = false;
        "signon.privateBrowsingCapture.enabled" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };
    };

    policies = {
      # This just doesnt work does it...
      GenerativeAI.Enabled = false;
      ExtensionSettings = let
        mozilla = "https://addons.mozilla.org/firefox/downloads/latest";
      in {
        # proton pass has a stupid id
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "${mozilla}/proton-pass/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
        "uBlock0@raymondhill.net" = {
          install_url = "${mozilla}/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
      };
    };
  };
}
