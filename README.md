# wine-stable-nix (v11.0_1)

Nix flake packaging of the [Gcenx macOS Wine builds](https://github.com/Gcenx/macOS_Wine_builds).

This flake provides `wine-stable` v11.0_1, a prebuilt Wine distribution for macOS.

## Usage

### Run without installing

```sh
nix run github:nobbmaestro/wine-stable-nix
```

### Flake usage

#### Add input

```nix
inputs.wine-stable.url = "github:nobbmaestro/wine-stable-nix";
```

#### Package usage

```nix
environment.systemPackages = [
  wine-stable.packages.aarch64-darwin.default
];
```

or dev shell:

```nix
devShells.default = pkgs.mkShell {
  packages = [
    wine-stable.packages.aarch64-darwin.default
  ];
};
```

### Overlay usage

The flake provides an overlay so `wine` can be used like a normal package from `nixpkgs`:

```nix
{
  inputs.wine-stable.url = "github:nobbmaestro/wine-stable-nix";
  outputs = inputs@{ nixpkgs, wine-stable, ... }:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ wine-stable.overlays.default ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [ pkgs.wine ];
    };
  };
}
```

After applying the overlay, `pkgs.wine` is available like a normal package.

## Upstream

[https://github.com/Gcenx/macOS_Wine_builds](https://github.com/Gcenx/macOS_Wine_builds)
