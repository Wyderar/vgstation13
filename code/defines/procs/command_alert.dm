//First argument can be a /datum/command_alert object or path. See "code/datums/helper_datums/command_alerts.dm" for more info

/proc/command_alert(var/text, var/title = "",var/force_report = 0,var/alert,var/noalert = 0)
	if(ispath(text, /datum/command_alert))
		var/datum/command_alert/CA = new text
		return CA.announce()
	else if(istype(text, /datum/command_alert))
		var/datum/command_alert/CA = text
		return CA.announce()

	if(!alert && !noalert)
		alert = 'sound/AI/commandreport.ogg'
	var/gibberish = map.linked_to_centcomm ? 0 : 1
	var/gibberish_main = (map.linked_to_centcomm || force_report) ? 0 : 1
	var/command
	command += "<h1 class='alert'>[gibberish ? Gibberish(command_name(),70): command_name()] Update</h1>"
	if (title && length(title) > 0)
		command += "<br><h2 class='alert'>[gibberish ? Gibberish(to_utf8(title),70) : to_utf8(title)]</h2>"


	command += {"<br><span class='alert'>[gibberish_main ? Gibberish(to_utf8(text),70) : to_utf8(text)]</span><br>
		<br>"}

	for(var/mob/M in player_list)
		if(!istype(M,/mob/new_player) && M.client)
			to_chat(M, command)
			if(!map.linked_to_centcomm)
				M << sound(pick(static_list), volume = 60)
			else if(!noalert)
				M << sound(alert, volume = 60)