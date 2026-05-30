{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        specialArgs.inputs = inputs;
        modules = [
          disko.nixosModules.disko
          ./disko
          ./nixos
          ./modules/nixos
        ];
      };
    };
  };
}
