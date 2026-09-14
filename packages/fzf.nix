{ fzf, makeWrapper, symlinkJoin }:
symlinkJoin {
  name = "fzf-wrapped";
  paths = [ fzf ];
  nativeBuildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/fzf \
      --add-flags "--color=bg:-1,bg+:-1,gutter:-1"
  '';
  meta.mainProgram = "fzf";
}
