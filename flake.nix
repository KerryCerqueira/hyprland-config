{
	description = "Kerry Cerqueira's hyprland confuguration";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		hyprland.url = "github:hyprwm/Hyprland";
		catppuccin.url = "github:catppuccin/nix";
	};
	outputs = { ... }@inputs : {
		homeManagerModules.default = import ./nix/home-manager inputs;
		nixosModules.default = import ./nix/nixos inputs;
	};
}
