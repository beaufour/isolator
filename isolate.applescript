#
# Small utility that turns on Isolator, but also sets DND status in Skype,
# Adium, and Hipchat
#
tell application "Isolator"
	set isolator_active to active
end tell

if isolator_active then
	tell application "Adium"
		go available
	end tell
	
	set skype_command to "SET USERSTATUS ONLINE"
	set hipchat_command to "/back"
else
	tell application "Adium"
		go away
	end tell
	
	set skype_command to "SET USERSTATUS DND"
	set hipchat_command to "/dnd"
end if

tell application "Skype"
	«event sendskyp» given «class cmnd»:skype_command, «class scrp»:"Isolator"
end tell

tell application "HipChat"
	activate
	# Hacky. If the focus is not in the text field, this won't work. Also it brings HipChat into the foreground
	tell application "System Events"
		keystroke hipchat_command
		key code 36
	end tell
end tell

tell application "System Events"
	keystroke "I" using command down
end tell