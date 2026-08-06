{
  description = "Ari's system configuration";

  outputs = {self, ...} @ inputs: let
    system = "x86_64-linux";

    nixpkgs = inputs.nixpkgs;
    home-manager = inputs.home-manager;
    stylix = inputs.stylix;
  in rec {
    packages.${system} = nixpkgs.legacyPackages.${system};
    formatter.${system} = packages.${system}.alejandra;

    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos-desktop/configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
        ];
      };

      # TODO: Deal with the rest of the nixosConfigurations
      # nixos-laptop = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
      #     ./hosts/nixos-laptop/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     stylix.nixosModules.stylix
      #   ];
      # };
      #
      # nixos-server = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs;};
      #   modules = [
      #     ./hosts/nixos-server/configuration.nix
      #   ];
      # };
    };
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
