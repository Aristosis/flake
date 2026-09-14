{
  inputs,
  pkgs,
  localPkgs,
  ...
}:
{
  hjem.users.ari = {
    packages = with pkgs; [
      setxkbmap
      umu-launcher
      localPkgs.gamering
      # (import "${inputs.self}/modules/pkgs/gamering.nix" pkgs)
    ];
    files =
      let
        entries = ".local/share/applications";
      in

      {
        "${entries}/ULTRAKILL.desktop".text = ''
          [Desktop Entry]
          Encoding=UTF-8
          Value=1.0
          Type=Application
          Name=ULTRAKILL
          Categories=Game;

          Icon=/home/ari/Share/Games/ULTRAKILL/icon.png
          Path=/home/ari/Share/Games/ULTRAKILL
          Exec="gamering" "/home/ari/Share/Games/ULTRAKILL/ULTRAKILL.exe"
        '';

        "${entries}/GTA III.desktop".text = ''
          [Desktop Entry]
          Encoding=UTF-8
          Value=1.0
          Type=Application
          Name=GTA III
          Categories=Game;

          Icon=/home/ari/Media/Share/Games/GTA III/Icons/icon.png
          Path=/home/ari/Media/Share/Games/GTA III
          Exec=sh -c 'setxkbmap cm; WINEDLLOVERRIDES="d3d8=n,b" exec gamering "$1"' sh "/home/ari/Media/Share/Games/GTA III/gta3.exe"
        '';

        "${entries}/GTA IV.desktop".text = ''
          [Desktop Entry]
          Encoding=UTF-8
          Value=1.0
          Type=Application
          Name=GTA IV
          Categories=Game;

          Icon=/home/ari/Media/Share/Games/GTA IV/Fixed/icon.png
          Path=/home/ari/Media/Share/Games/GTA IV
          Exec="/home/ari/Media/Share/Games/GTA\ IV/Fixed/run.sh"
        '';
      };
  };
}
