# Nix NodeJS 20.10.0

A NodeJS development environment as a Nix flake, based on:
- NodeJS 20.10.0
- Watchman
- mkcert

## Usage

### Ad-hoc shell

```shell
nix develop github:what-the-functor/nix-node
```

### direnv

`.envrc`
```
use flake github:what-the-functor/nix-node
```
