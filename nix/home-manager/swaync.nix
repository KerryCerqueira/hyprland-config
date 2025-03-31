{ self, ... }: { pkgs, ... }:

let
	dotfilesPath = builtins.path { path = "${self}/src"; name = "src"; };
	swayncConfig = (
		builtins.fromJSON (builtins.readFile (dotfilesPath + "/swaync/config.json"))
		// {"$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";}
	);
in {
	xdg.configFile.".config/swaync/config.json".text = builtins.toJSON swayncConfig;
	home.packages = with pkgs; [ swaynotificationcenter ];
}
