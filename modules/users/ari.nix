{
  inputs,
  ...
}:
{
  imports = [
    "${inputs.self}/modules/programs"
  ];

  users.users.ari = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ ];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hjem.users.ari =
    let
      config = "${inputs.self}/config";
    in
    {
      enable = true;
      user = "ari";
      directory = "/home/ari";
      clobberFiles = true;
      xdg.config.files = {
        "niri".source = "${config}/niri";
        "waybar".source = "${config}/waybar";
        "foot".source = "${config}/foot";
        "fuzzel".source = "${config}/fuzzel";
        "nvim".source = "/home/ari/media/projects/flake/config/nvim";
        "user-dirs.dirs".text = ''
XDG_DESKTOP_DIR="media/hdd/desktop"
XDG_DOCUMENTS_DIR="media/hdd/documents"
XDG_PICTURES_DIR="media/hdd/pictures"
XDG_MUSIC_DIR="media/hdd/music"
XDG_VIDEOS_DIR="media/hdd/videos"
XDG_DOWNLOAD_DIR="media/downloads"
XDG_PROJECTS_DIR="media/projects"
XDG_TEMPLATES_DIR="/var/empty"
XDG_PUBLICSHARE_DIR="/var/empty"
        '';
      };
    };
}
