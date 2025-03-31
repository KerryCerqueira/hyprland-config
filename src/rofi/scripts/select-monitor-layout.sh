#!/usr/bin/env bash

# Directory containing monitor configurations
LAYOUTS_DIR="$HOME/.config/hypr/config.d/monitor-layouts"

# Generate the list of subdirectories (monitor configurations)
list_layouts() {
	echo "nwg-displays layout"
	find "$LAYOUTS_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;
}

# Call `hyprland keyword source` for the selected configuration
apply_layout() {
	LAYOUT_NAME="$1"
	if [[ "$LAYOUT_NAME" == "nwg-displays layout" ]]; then
		MONITORS_PATH="$HOME/.config/hypr/monitors.conf"
		WORKSPACES_PATH="$HOME/.config/hypr/workspaces.conf"
	else
		MONITORS_PATH="$LAYOUTS_DIR/$LAYOUT_NAME/monitors.conf"
		WORKSPACES_PATH="$LAYOUTS_DIR/$LAYOUT_NAME/workspaces.conf"
	fi
	if [[ -f "$MONITORS_PATH" ]]; then
		hyprctl keyword source "$MONITORS_PATH"
		if [[ -f "$WORKSPACES_PATH" ]]; then
			hyprctl keyword source "$WORKSPACES_PATH"
		else
			notify-send "workspaces.conf not found for profile $LAYOUT_NAME."
		fi
	else
		notify-send "monitors.conf not found for profile $LAYOUT_NAME."
	fi
}

# Rofi mode
if [[ -z "$@" ]]; then
	# Display config names (basenames)
	list_layouts
else
	# Apply selected config
	apply_layout "$@"
fi
