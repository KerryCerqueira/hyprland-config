{ pkgs, self, ... }:
let
	dotfilesPath = builtins.path { path = "${self}/src"; name = "src"; };
in {
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		plugins = with pkgs; [
			(rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
			# (rofi-file-browser.override { rofi= rofi-wayland-unwrapped; })
			(rofi-top.override { rofi-unwrapped = rofi-wayland-unwrapped; })
		];
	};
	xdg.configFile."rofi/conf.d" = {
		source = dotfilesPath + /rofi;
		recursive = true;
	};
}
