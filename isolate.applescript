#
# Small utility that:
# * activates Isolator
# * sets DND status in Skype and Adium
# * disables notifications
#
tell application "Isolator"
	set isolator_active to active
end tell

if isolator_active then
	tell application "Adium"
		go available
	end tell
	
	set skype_command to "SET USERSTATUS ONLINE"
	enableNotificationCenter()
else
	tell application "Adium"
		go away
	end tell
	
	set skype_command to "SET USERSTATUS DND"
	disableNotificationCenter()
end if

tell application "Skype"
	send command skype_command script name "Isolator"
end tell

tell application "System Events"
	keystroke "I" using command down
end tell

# These are super ugly. There surely must be a better way?
on disableNotificationCenter()
	do shell script "defaults write ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist doNotDisturb -boolean true"
	set theDate to quoted form of (do shell script "date +\"%Y-%m-%d %I:%M:%S +0000\"")
	do shell script "defaults write ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist doNotDisturbDate -date " & theDate
	do shell script "killall NotificationCenter"
end disableNotificationCenter

on enableNotificationCenter()
	do shell script "defaults write ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist doNotDisturb -boolean false"
	try
		do shell script "defaults delete ~/Library/Preferences/ByHost/com.apple.notificationcenterui.*.plist doNotDisturbDate"
	end try
	do shell script "killall NotificationCenter"
end enableNotificationCenter
