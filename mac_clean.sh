#!/bin/bash

# 改變自動備份週期 (8小時：3600 s * 8)
defaults write /System/Library/Launch Daemons/com.apple.backupd-auto StartInterval -int 288000

# 清理Caches
rm -r ~/Library/Caches/*

# 重新排序 mac launcher
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock

# 清理磁碟碎片
diskutil secureErase freespace 3 /Volumes/Macintosh\ HD

# 刪除.DS_Store
sudo find / -name ".DS_Store" -depth -exec rm {} \;

#say -o audio.aiff -f FILENAME.txt
