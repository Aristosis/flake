{ pkgs, ... }:
{
  services = {
    displayManager.ly.enable = true;
    gvfs.enable = true;
  };

  programs.niri.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      iosevka
      nerd-fonts.symbols-only
    ];
  };
}
