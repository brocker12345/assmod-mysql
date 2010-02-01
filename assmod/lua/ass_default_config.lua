
ASS_Config["writer"] = "Default Writer"
ASS_Config["max_temp_admin_time"] = 	4 * 60
ASS_Config["max_temp_admin_ban_time"] = 1 * 60

ASS_Config["bw_background"] = 1
ASS_Config["tell_admins_what_happened"] = 1

ASS_Config["demomode"] = 0
ASS_Config["demomode_ta_time"] = 30

ASS_Config["admin_speak_prefix"] = "@"

ASS_Config["reasons"] = {
		
	{	name = "Text Spamming",	        			reason = "Text Spamming - Rule #22"						},
	{	name = "Microphone Spamming",				reason = "Mic. Spamming - Rule #22"						},
	{	name = "Punchwhoring",	        			reason = "Punchwhoring - Rule #14"							},
	{	name = "Admin Disrespect",					reason = "Admin Disrespect - Rule #12"						},
	{	name = "Career Camping",					reason = "Career Camping - Rule #20"						},
	{	name = "Prop Deathmatch/Surfing/Blocking",	reason = "Prop Deathmatch/Surfing/Blocking - Rule #1"		},
	{ 	name = "Metagaming",						reason = "Metagaming - Rule #9"							},
	{ 	name = "Breaking NLR",						reason = "Breaking NLR - Rule #11"							},
	{ 	name = "Building/Walking on Roof",			reason = "Building/Walking on Roof. -Rule #23"				},
	{ 	name = "Random Deathmatch",					reason = "Random Deathmatch (RDM) - Rule #10"				},
	{ 	name = "Begging",							reason = "Do not beg for loans / money. - Rule #3"			},
	{ 	name = "Not Roleplaying.",					reason = "Learn to Roleplay - Rule #13"					},
	{ 	name = "Spamming Car Alarm",				reason = "Spamming Car Alarms - Rule #19"					},
	{ 	name = "Grand Theft Auto",					reason = "Grand Theft Auto - Rule #21"						},
	{ 	name = "Flaming",							reason = "Flaming - Rule #39"								},
	{ 	name = "All caps in OOC",					reason = "All Caps in OOC - Rule #6"						},
}

ASS_Config["ban_times"] = {

	{ 	time = 1,		name = "1 Min"		},
	{ 	time = 5,		name = "5 Min"		},
	{ 	time = 15,		name = "15 Min"		},
	{ 	time = 30,		name = "30 Min" 	},
	{ 	time = 45,		name = "45 Min" 	},
	{ 	time = 60,		name = "1 Hour"		},
	{ 	time = 60 * 2,		name = "2 Hours"	},
	{ 	time = 60 * 6,		name = "6 Hours"	},
	{ 	time = 60 * 24 * 1,	name = "1 Day"		},
	{ 	time = 60 * 24 * 2,	name = "2 Days"		},
	{ 	time = 60 * 24 * 4,	name = "4 Days"		},
	{ 	time = 60 * 24 * 7,	name = "1 Week"		},
	{ 	time = 60 * 24 * 14,	name = "2 Weeks"	},
	{ 	time = 60 * 24 * 21,	name = "3 Weeks"	},
	{ 	time = 60 * 24 * 31,	name = "1 Month"	},
	{ 	time = 0,		name = "Perma"		},

}

ASS_Config["temp_admin_times"] = {

	{ 	time = 5,		name = "5 Min"		},
	{ 	time = 15,		name = "15 Min"		},
	{ 	time = 30,		name = "30 Min" 	},
	{ 	time = 60,		name = "1 Hour"		},
	{ 	time = 120,		name = "2 Hours"	},
	{ 	time = 240,		name = "4 Hours"	},

}

ASS_Config["fixed_notices"] = {

	{	duration = 10,		text = "Welcome to %hostname%. Please play nice!"			},
	{	duration = 10,		text = "Running %gamemode% on %map%"					},
	{	duration = 10,		text = "%assmod% - If you're an admin, bind a key to +ASS_Menu"		},

}
		
ASS_Config["rcon"] = {

	{	cmd = "sv_voiceenable 1"	},
	{	cmd = "sv_voiceenable 0"	},
	{	cmd = "sv_noclipaccelerate 10" 	},
	{	cmd = "sv_noclipaccelerate 6" 	},
	
	
}