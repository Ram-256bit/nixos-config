{
  description = "My first flake!";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
	# specialArgs = { inherit inputs; };
	modules = [ ./configuration.nix ];
      };
    };
  };

}
