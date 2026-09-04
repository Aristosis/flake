{
  inputs,
  pkgs,
  ...
}: {
  hjem.users.ari = {
    packages = with pkgs; [
      umu-launcher
      (
        import "${inputs.self}/modules/pkgs/gamering.nix" pkgs
      )
    ];
    files = 
    let
      entries = ".local/share/applications";
      in
      {
      "${entries}/ULTRAKILL.desktop".text =
        ''
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
    };
  };
}
