{ pkgs, ... }:
{
	services.udisks2.enable = true;
	qt = {
		enable = true;
		platformTheme = "qt5ct";
	};
	environment.systemPackages = with pkgs; [
		# kde wayland support
		libsForQt5.qt5.qtwayland
		# file manager
		libsForQt5.dolphin
		libsForQt5.dolphin-plugins
		# icon support for dolphin
		libsForQt5.qt5.qtsvg
		# thumbnailers and file previews for dolphin
		libsForQt5.kdegraphics-thumbnailers
		libsForQt5.kimageformats
		libsForQt5.qtimageformats
		kdePackages.kdesdk-thumbnailers
		libsForQt5.ffmpegthumbs
		kdePackages.taglib
		resvg
		# terminal for dolphin
		libsForQt5.konsole
		# compare tool for dolphin
		libsForQt5.kompare
		# metadata search for dolphin
		libsForQt5.baloo
		# file archiver
		libsForQt5.ark
	];
}
