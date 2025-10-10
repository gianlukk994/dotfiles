#!/bin/bash

persistent_applications=(
    "/System/Applications/System Preferences.app"
    "/System/Applications/Calendar.app"
    "/Applications/Spotify.app"
    "/Applications/iTerm.app"
    "/Applications/Notion.app"
    "/System/Applications/Notes.app"
    "/Applications/Todoist.app"
    "/Applications/Visual Studio Code.app"
    "/Applications/Brave.app"
    "/Applications/Spark.app"
    "/Applications/Fellow.app"
    "/Applications/Harvest.app"
    "/Applications/Loom.app"
    "/Applications/Asana.app"
    "/Applications/Slack.app"
    "/Applications/Discord.app"
    "/Applications/WhatsApp.app"
    "/Applications/Telegram.app"
    "/Applications/Twitter.app"
    "/Applications/Postman.app"
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

# Load preferences from a custom directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Specify the custom directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.dotfiles/.iterm2"

killall Dock