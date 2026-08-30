pkgs:
  pkgs.symlinkJoin {
    name = "niri-wrapped-${pkgs.niri.version}";
    paths = [ pkgs.niri ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/niri" \
      --set NIRI_CONFIG "${builtins.toString ./config/config.kdl}"
      '';
    meta.mainProgram = "niri";
  };
