{pkgs, ...}: {
  home.pointerCursor.enable = true;
  stylix = let
    themes = "${pkgs.base16-schemes}/share/themes";
  in {
    enable = true;
    overlays.enable = false;
    base16Scheme = "${themes}/gruvbox-dark-medium.yaml";
    cursor = {
      size = 16;
      package = pkgs.material-cursors;
      name = "material_light_cursors";
    };
    fonts = with pkgs; {
      monospace.package = iosevka;
      monospace.name = "Iosevka";
      serif.package = inter;
      serif.name = "Inter";
      sansSerif.package = inter;
      sansSerif.name = "Inter";
      sizes.applications = 12;
      sizes.terminal = 14;
      sizes.desktop = 13;
      sizes.popups = 14;
    };
    opacity = {
      terminal = 0.9;
      popups = 0.9;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    polarity = "dark";
  };
}
