{
  description = "My NixOS configuration";


  inputs = {
    # Go back to nixos-unstable after PR 238700 is merged
    # https://nixpk.gs/pr-tracker.html?pr=238700
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    #sops-nix.url = "github:mic92/sops-nix"; #todo

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:misterio77/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefly = {
      url = "github:timhae/firefly";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disconic.url = "github:misterio77/disconic";
    website.url = "github:misterio77/website";
    paste-misterio-me.url = "github:misterio77/paste.misterio.me";
    yrmos.url = "github:misterio77/yrmos";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      templates = import ./templates;

      overlays = import ./overlays { inherit inputs outputs; };
      hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      wallpapers = import ./home/iggut/wallpapers;

      nixosConfigurations = {
        # Main desktop
        gaminix =  lib.nixosSystem {
          modules = [ ./hosts/gaminix ];
          specialArgs = { inherit inputs outputs; };
        };
        # Secondary desktop
        maia = lib.nixosSystem {
          modules = [ ./hosts/gaminix ];
          specialArgs = { inherit inputs outputs; };
        };
        # Personal laptop
        gs66 = lib.nixosSystem {
          modules = [ ./hosts/gs66 ];
          specialArgs = { inherit inputs outputs; };
        };
        # Media server (RPi)
        merope = lib.nixosSystem {
          modules = [ ./hosts/merope ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Desktops
        "iggut@gaminix" = lib.homeManagerConfiguration {
          modules = [ ./home/iggut/gaminix.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "iggut@maia" = lib.homeManagerConfiguration {
          modules = [ ./home/iggut/maia.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "iggut@gs66" = lib.homeManagerConfiguration {
          modules = [ ./home/iggut/gs66.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "iggut@merope" = lib.homeManagerConfiguration {
          modules = [ ./home/iggut/merope.nix ];
          pkgs = pkgsFor.aarch64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "iggut@generic" = lib.homeManagerConfiguration {
          modules = [ ./home/iggut/generic.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
