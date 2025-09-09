{
  description = "twf is a standalone tree view explorer inspired by fzf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
  };

  outputs = { flakelight, ... }@inputs:
    flakelight ./. ({ pkgs, ... }: {
      package = { buildGoModule, ... }:
        buildGoModule {
          pname = "twf";
          version = "1.0.0";
          src = ./.;
          vendorHash = "sha256-8WoMXoUNWAbT5FPfyuml/M+XqFbKjLuBQtDvOt1ls0M=";
          proxyVendor = true;
       };

      devShell = {
        packages = pkgs: with pkgs; [ go ];
      };

      app = { twf, ... }: "${twf}/bin/twf";

      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" "armv7l-linux" ];
    });
}