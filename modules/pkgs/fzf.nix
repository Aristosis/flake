pkgs:
pkgs.symlinkJoin {
  name = "fzf-wrapped";
  paths = [ pkgs.fzf ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/fzf \
      --add-flags "--color=bg:-1,bg+:-1,gutter:-1"
  '';
  meta.mainProgram = "fzf";
}
