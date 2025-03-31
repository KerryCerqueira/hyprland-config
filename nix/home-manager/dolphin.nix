{ self, ... }: { ... }:

let
	dotfilesPath = builtins.path { path = "${self}/src"; name = "src"; };
in {
	xdg.dataFile = {
		"konsole/catppuccin-mocha.colorscheme".source = dotfilesPath + "/konsole/catppuccin-mocha.colorscheme";
		"konsole/Default.profile".source = dotfilesPath + "/dotfiles/konsole/Default.profile";
	};
	xdg.configFile.".config/konsolerc".source = dotfilesPath + "konsole/konsolerc";
}
