{
  description = "Flake Configuration";
  inputs = 
  {
    # nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-22.05";

    home-manager =
    {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      # pkgs = import nixpkgs
      # {
      #   inherit system;
      #   config = 
      #   { allowUnfree = true; };
      # };

      # lib = nixpkgs.lib;

    in 
    {
      homeConfigurations = 
      {
        alfurqani = home-manager.lib.homeManagerConfiguration 
        {
          inherit pkgs;

          modules = 
          [
            ({pkgs, ...}:
            {
              home.stateVersion = "22.05";
              home.username = "alfurqani";
              home.homeDirectory = "/home/alfurqani";

              home.packages = with pkgs; 
              [
                git
                neofetch
              ];
            })
          ];
        };
      };

      # nixosConfigurations =
      # {
      #   nixos = lib.nixosSystem
      #   {
      #     inherit system;

      #     modules = 
      #     [
      #       ./etc/nixos/configuration.nix
      #     ];
      #   };
      # };

    };
  
}
