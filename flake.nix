{
  description = "My first flake!";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, catppuccin, zen-browser, ... } @ inputs:
    let
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
	
	# specialArgs = { inherit inputs; };
	modules = [ 
	  ./configuration.nix
	  catppuccin.nixosModules.catppuccin
	];
      };
    };
  };

}
