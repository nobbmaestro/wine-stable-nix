{
  description = "Wine builds for macOS (Gcenx)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" ];
      perSystem =
        { pkgs, ... }:
        let
          wine = pkgs.callPackage ./package.nix { };
        in
        {
          packages = {
            wine = wine;
            default = wine;
          };
        };
      flake = {
        overlays.default = final: prev: {
          wine = final.callPackage ./package.nix { };
        };
      };
    };
}
