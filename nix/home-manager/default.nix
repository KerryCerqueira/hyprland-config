inputs: { pkgs, self, hyprland, catppuccin, ... }:

let
	system = pkgs.stdenv.hostPlatform.system;
	dotfilesPath = builtins.path { path = "${self}/src"; name = "src"; };
in
{
	home.packages = with pkgs; [
		nwg-drawer
		nwg-dock-hyprland
		nwg-displays
		wdisplays
	];
	imports = [
		./dolphin.nix
		./rofi.nix
		./swaync.nix
		./zathura.nix
		catppuccin.homeManagerModules.catppuccin
	];
	catppuccin = {
		cursors.enable = true;
		kvantum.enable = true;
		hyprland.enable = true;
		gtk.enable = true;
	};
	qt = {
		enable = true;
		platformTheme.name = "kvantum";
		style.name = "kvantum";
	};
	gtk = {
		enable = true;
		#TODO: resolve this option if noto sans doesn't exist or add a mechanism to
		# satisfy this dependency
		font.name = "Noto Sans";
		font.size = 10;
		iconTheme.name = "Papirus-Dark";
		cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
	};
	xdg.configFile = {
		"qt5ct/qt5ct.conf".source = dotfilesPath + /qt5ct/qt5ct.conf;
		"kdeglobals".text = #toml
		''
		[General]
			TerminalApplication=kitty
		'';
		"waybar/" = {
			source = dotfilesPath + /waybar;
			recursive = true;
		};
		"hypr/config.d" = {
			source = dotfilesPath + /hypr/config.d;
			recursive = true;
		};
		"hypr/hyprpaper.conf".source = dotfilesPath + /hypr/hyprpaper.conf;
		"hypr/hyprlock.conf".source = dotfilesPath + /hypr/hyprlock.conf;
		"hypr/hypridle.conf".source = dotfilesPath + /hypr/hypridle.conf;
	};
	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = "source = ./config.d/general.conf";
		package = hyprland.packages.${system}.hyprland;
		portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
	};
	services = {
		hyprpaper = {
			enable = true;
			settings = {
				preload = "~/.config/hypr/images/fingerprint.jpg";
				wallpaper = ",~/.config/hypr/images/fingerprint.jpg";
			};
		};
		swayosd.enable = true;
		blueman-applet.enable = true;
		batsignal = {
			enable = true;
			extraArgs = [
				"-P Charging battery"
				"-C Battery critical. System will hibernate at 2% battery."
				"-U Battery discharging"
			];
		};
	};
}
