{inputs, ...}: {
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {};

  nur = inputs.nur.overlay;

  unstable-packages = final: _prev: {
    unstablePkgs = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
