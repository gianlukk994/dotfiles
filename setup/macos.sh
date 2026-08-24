#!/usr/bin/env bash
#
# Apply macOS defaults and configure the Dock.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../lib/utils.sh
source "${SCRIPT_DIR}/../lib/utils.sh"

fancy_echo "<<< Starting macOS Setup >>>"

persistent_applications=(
    "/System/Applications/System Preferences.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Spotify.app"
    "/Applications/WezTerm.app"
    "/Applications/WhatsApp.app"
    "/System/Applications/Notes.app"
    "/Applications/Spark.app"
    "/Applications/Slack.app"
    "/Applications/Telegram.app"
    "/Applications/Notion Calendar.app"
    "/Applications/Notion.app"
    "/Applications/TradingView.app"
    "/Applications/Brave.app"
    "/Applications/ChatGPT Classic.app"
    "/Applications/Orca.app"
    "/Applications/Home Assistant.app"
)

########### UI ###########

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

########### Dock ###########

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36
# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# Do not show recent application
defaults write com.apple.dock show-recents -bool false

# Add persistent applications
for app in "${persistent_applications[@]}"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

if ! is_ci; then
    killall Dock || true
fi
