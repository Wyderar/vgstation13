/*
KeyState library
Created by Loduwijk
June 2005
*/

proc/keycode2char(N)
	switch(N)
		if(9)return "	"
		if(13)return ascii2text(13)
		if(32)return " "
		if(48 to 57)
			return ascii2text(N)
		if(65 to 90)
			return ascii2text(N)
		if(186)return ";"
		if(187)return "="
		if(188)return ","
		if(189)return "-"
		if(190)return "."
		if(191)return "/"
		if(192)return "`"
		if(219)return "\["
		if(220)return "\\"
		if(221)return "]"
		if(222)return "'"
		else return 0

KeyState
	var
		client/client
		shift = 0
		list/key[255]
		mouse_x=0;mouse_y=0
	New(client/C)
		if(C)client=C
		var/index
		for(index = 1 to 255)
			key[index]=0
	proc
		Update(event,KeyCode)
			var/T=KeyCode
			KeyCode=text2num(KeyCode)
			switch(event)
				if("MouseCoordinate")
					mouse_x=copytext(T,1,findtext(T,","))
					mouse_y=copytext(T,findtext(T,",")+1,0)

client
	var
		KeyState/keystate
		resolution
		avail_resolution
		system_type
		color_quality
	Topic(href,href_list[])
		if("action" in href_list)
			if(href_list["action"]=="KeyState")
				var/event = href_list[2]
				keystate.Update(event,href_list[event])
			if(href_list["action"]=="infosetup")
				resolution=href_list["resolution"]
				avail_resolution=href_list["availresolution"]
				color_quality=href_list["color"]
				system_type=href_list["os"]
		return ..()
	verb/manual_focus()
		set hidden = 1
		if(!keystate)return
	proc
		//info return functions
		resolution()return resolution
		avail_resolution()return avail_resolution
		system_type()return system_type
		color_quality()return color_quality
		//action functions
		InfoSetup()
			src<<browse({"
<html>
<head>
</head>
<body>
<script type="text/javascript">
resolution=screen.width+","+screen.height
avail_res=screen.availWidth+","+screen.availHeight
avail_y=screen.availHeight
color=screen.colorDepth
os=navigator.platform
window.location="?action=infosetup&resolution="+resolution+"&availresolution="+avail_res+"&color="+color+"&os="+os
</script>
</body>
</html>
"},"window=infosetup;size=0x0;can_resize=0;titlebar=0")
		MouseUpdate()
			src<<browse({"
<html>
<head>
<script type="text/javascript">
function coordinate(event)
{
window.location="?action=KeyState&MouseCoordinate="+event.screenX+","+event.screenY
}
</script>
</head>
<body onload="coordinate(event)">
</body>
</html>
"},"window=coordinate;size=0x0;can_resize=0;titlebar=0")