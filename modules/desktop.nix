{pkgs, ...}: {
  imports = [
    ./niri.nix
  ];

  services = {
    displayManager.ly.enable = true;
    gvfs.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      iosevka
      nerd-fonts.symbols-only
    ];
  };
}
