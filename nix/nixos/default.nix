{ hyprland, catppuccin, ... }: { pkgs, ... }:
let
	system = pkgs.stdenv.hostPlatform.system;
in
{
	imports = [
		./dolphin.nix
		catppuccin.nixosModules.catppuccin
	];
	nix.settings = {
		substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
	};
	programs = {
		hyprland = {
			enable = true;
			package = hyprland.packages.${system}.hyprland;
			portalPackage = hyprland.packages.${system}.xdg-desktop-portal-hyprland;
		};
		iio-hyprland.enable = true;
		nm-applet.enable = true;
		hyprlock.enable = true;
		ssh.startAgent = true;
		dconf.enable = true;
	};
	security.pam.services.hyprlock.fprintAuth = false;
	powerManagement.enable = true;
	services = {
		blueman.enable = true;
		xserver.excludePackages = [ pkgs.xterm ];
		upower.enable = true;
		thermald.enable = true;
		auto-cpufreq = {
			enable = true;
			settings = {
				battery = {
					governor = "powersave";
					turbo = "never";
				};
				charger = {
					governor = "performance";
					turbo = "auto";
				};
			};
		};
	};
	environment.systemPackages = with pkgs; [
		kitty
		waybar
		libnotify
		pavucontrol
		brightnessctl
		wlr-randr
		kanshi
		hyprpolkitagent
		hyprshot
		wl-clipboard
		papirus-icon-theme
		wvkbd
		zenity
		image-roll
	];
}
