{pkgs, ...}: {
  stylix = let
    themes = "${pkgs.base16-schemes}/share/themes";
  in {
    enable = true;
    overlays.enable = false;

    base16Scheme = "${themes}/ashes.yaml";
    polarity = "dark";

    cursor = {
      size = 16;
      package = pkgs.material-cursors;
      name = "material_light_cursors";
    };

    fonts = with pkgs; {
      monospace = {
        package = iosevka;
        name = "Iosevka";
      };

      serif = {
        package = inter;
        name = "Inter";
      };
      sansSerif = {
        package = inter;
        name = "Inter";
      };

      sizes = {
        applications = 12;
        terminal = 14;
        desktop = 13;
        popups = 14;
      };
    };

    opacity = {
      terminal = 0.95;
      popups = 0.9;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}
