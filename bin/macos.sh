#!/usr/bin/env bash
set -e

echo "Applying macOS defaults..."


# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 52 pixels
defaults write com.apple.dock tilesize -int 52

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

### Dock Tweaks ###
# Speed up desktop switching animations
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES

# Faster Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable Dock magnification for faster response
defaults write com.apple.dock magnification -bool false

# Restore minimized windows when clicking dock icon
defaults write com.apple.dock minimize-to-application -bool false

# Auto-hide Dock instantly
defaults write com.apple.dock autohide-delay -float 0

# Speed up the Dock's show/hide animation
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Immediately switch Spaces when clicking on Dock apps
defaults write com.apple.dock workspaces-auto-swoosh -bool YES

# Force Dock to react instantly when mouse touches edge
defaults write com.apple.dock mouse-over-hint -bool true

# Restart Dock to apply settings
killall Dock

### Finder Tweaks ###
# Always show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show full path in Finder title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Restart Finder to apply settings
killall Finder

# Speed up window resize animations
defaults write -g NSWindowResizeTime -float 0.001

# Disable most animations in Quick Look & other system dialogs
defaults write -g QLPanelAnimationDuration -float 0

# Disable automatic sheet slide-down animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Speed up App switching (Cmd+Tab) animations
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES

echo "macOS tweaks applied ✅"
