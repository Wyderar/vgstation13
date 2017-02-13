/proc/captain_announce(var/text)
	to_chat(world, "<h1 class='alert'>Priority Announcement</h1>")
	to_chat(world, "<span class='alert'>[to_utf8(text)]</span>")
	to_chat(world, "<br>")

