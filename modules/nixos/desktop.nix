{ pkgs, ... }: {
  imports = [
    ./niri.nix
  ];

  services = {
    displayManager.ly = {
      enable = true;
      settings.session_log = ".local/state/ly-session.log";
    };
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
