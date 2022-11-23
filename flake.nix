{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = {self, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      # https://search.nixos.org/ <-- mencari packages apa saja yang
      # tersedia di nix;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        alfurqani = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ({pkgs, ...}:{
              home.stateVersion = "22.05";
              home.username = "alfurqani";
              home.homeDirectory = "/home/alfurqani";

              home.packages = with pkgs; [
                git
                neofetch
              ];
            })
          ];
        };
      };
    };
  
}
