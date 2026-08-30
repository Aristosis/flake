{
  pkgs,
  ...
}:
let
  niri-pkg = pkgs.symlinkJoin {
    name = "niri-wrapped-${pkgs.niri.version}";
    paths = [ pkgs.niri ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/niri" \
        --set NIRI_CONFIG "${builtins.toString ./config/config.kdl}"
    '';
    meta.mainProgram = "niri";
  };
in
{
  programs.niri = {
    enable = true;
    package = niri-pkg;
  };
}
