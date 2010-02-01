
local PLUGIN = {}

PLUGIN.Name = "Freeze"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "10th August 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (SERVER) then

	ASS_NewLogLevel("ASS_ACL_FREEZE")
	
	function PLUGIN.Freeze( PLAYER, CMD, ARGS )

		if (PLAYER:IsTempAdmin()) then

			local TO_FREEZE = ASS_FindPlayer(ARGS[1])

			if (!TO_FREEZE) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (TO_FREEZE:IsBetterOrSame(PLAYER)) then

				// disallow!
				ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_FREEZE:Nick() .. "\" has same or better access then you.")
				return

			end

			if (ASS_RunPluginFunction( "AllowFreeze", true, PLAYER, TO_FREEZE )) then

				TO_FREEZE:Freeze(true)
				SendLog(PLAYER:Nick(), "FREEZE_PLAYER", TO_FREEZE:Nick(), "Froze")
				
			end

		end

	end
	concommand.Add("ASS_Freeze", PLUGIN.Freeze)

	function PLUGIN.UnFreeze( PLAYER, CMD, ARGS )

		if (PLAYER:IsTempAdmin()) then

			local TO_UNFREEZE = ASS_FindPlayer(ARGS[1])

			if (!TO_UNFREEZE) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end

			if (ASS_RunPluginFunction( "AllowUnFreeze", true, PLAYER, TO_UNFREEZE )) then

				TO_UNFREEZE:Freeze(false)
				SendLog(PLAYER:Nick(), "FREEZE_PLAYER", TO_UNFREEZE:Nick(), "Unfroze")
				
			end

		end

	end
	concommand.Add("ASS_UnFreeze", PLUGIN.UnFreeze)

end

if (CLIENT) then

	function PLUGIN.Freeze(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand("ASS_Freeze", PLAYER:UniqueID())

	end
	
	function PLUGIN.UnFreeze(PLAYER)

		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand("ASS_UnFreeze", PLAYER:UniqueID())

	end

	function PLUGIN.AddMenu(DMENU)			
	
		DMENU:AddSubMenu( "Freeze",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer"}, PLUGIN.Freeze ) end ):SetImage( "gui/silkicons/status_offline" )
		DMENU:AddSubMenu( "Unfreeze", nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer"}, PLUGIN.UnFreeze ) end ):SetImage( "gui/silkicons/user" )

	end

end

ASS_RegisterPlugin(PLUGIN)


