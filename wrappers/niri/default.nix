{
pkgs,
...
}:
{
  programs.niri.package = (
    pkgs.symlinkJoin {
      passthru = pkgs.niri.passthru;
      name = "niri-wrapped-${pkgs.niri.version}";
      paths = [ pkgs.niri ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/niri-session" \
        --set NIRI_CONFIG "${builtins.toString ./config/config.kdl}"
        '';
      meta.mainProgram = "niri";
    }
  );
}
