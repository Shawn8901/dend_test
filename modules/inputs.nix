{
  flake-file.inputs = {
    nixpkgs.url = "github:shawn8901/nixpkgs/nixos-unstable-custom";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.11";
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

}
