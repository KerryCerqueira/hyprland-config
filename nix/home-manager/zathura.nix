{ self, ... }: { pkgs, ... }:

let
	dotfilesPath = builtins.path { path = "${self}/src"; name = "src"; };
in {
	programs.zathura = {
		enable = true;
		extraConfig = "include theme";
	};
	xdg.configFile."zathura/theme".source = dotfilesPath + "/zathura/theme";
}

