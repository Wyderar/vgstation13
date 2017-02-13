client
	var/manual_focus = 0
KeyState
	var/key_repeat = 0
	var/open = 1
	proc
		open()
			open = 1
		close()
			open = 0
			if(client)client<<browse(null,null)