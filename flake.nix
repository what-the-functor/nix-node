{
  description = "Development environment with Node.js 20.10.0";

  nixConfig = {
    extra-substituters =
      [ "https://cache.nixos.org/" "https://what-the-functor.cachix.org" ];
    extra-trusted-public-keys = [
      "what-the-functor.cachix.org-1:vViwgCygz4IIkjkHMWFpzSXJY68J8BSCuzweSwlSBsk="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        nodeVersion = "20.10.0";
        node = pkgs.nodejs_20.overrideAttrs (prev: {
          version = nodeVersion;
          src = pkgs.fetchurl {
            url =
              "https://nodejs.org/dist/v${nodeVersion}/node-v${nodeVersion}.tar.xz";
            sha256 = "0dams6x06m38ral4gb95ps7frrrbnia1wqz6fiawvjnqxdp2bsrj";
          };
        });

      in {
        devShells = {

          # Default environment for NodeJS development
          default =
            pkgs.mkShell { packages = [ pkgs.mkcert node pkgs.watchman ]; };

          # Nix environment for development of this flake
          # See .envrc at the root of this project
          nix =
            pkgs.mkShell { packages = [ pkgs.cachix pkgs.nixd pkgs.nixfmt ]; };
        };
      });
}
