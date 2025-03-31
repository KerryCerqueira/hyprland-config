{
	description = "Kerry Cerqueira's hyprland confuguration";
	inputs = {
		hyprland.url = "github:hyprwm/Hyprland";
		catppuccin.url = "github:catppuccin/nix";
	};
	outputs = { ... }@inputs : {
		homeManagerModules.hyprland-config = import ./nix/home-manager inputs;
		nixosModules.hyprland-config = import ./nix/nixos inputs;
	};
}
