
local PLUGIN = {}

PLUGIN.Name = "Reset Skills"
PLUGIN.Author = "HuntsKikBut"
PLUGIN.Date = "21st September 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = { "perp" } // only load this plugin for sandbox and it's derivatives

if (SERVER) then

	function PLUGIN.Freeze( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() < 2) then

			local TO_FREEZE = ASS_FindPlayer(ARGS[1])

			if (!TO_FREEZE) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end

			TO_FREEZE:ResetSkills();
			PLAYER:PrintMessage(HUD_PRINTTALK, TO_FREEZE:Nick() .. "'s skills reset.");
			TO_FREEZE:PrintMessage(HUD_PRINTTALK, PLAYER:Nick() .. " has reset your skills. If you feel this is abuse, screenshot this message and report it on the forums.");

		else
		
			ASS_MessagePlayer(PLAYER, "Access denied!")
			
		end

	end
	concommand.Add("ASS_ResetSkills", PLUGIN.Freeze)
	
end

if (CLIENT) then

	function PLUGIN.ResetSkills(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand("ASS_ResetSkills", PLAYER:UniqueID())

	end
	function PLUGIN.AddGamemodeMenu(DMENU)			
	
		DMENU:AddSubMenu( "Reset Skills",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer"}, PLUGIN.ResetSkills ) end ):SetImage( "gui/silkicons/status_offline" )

	end

end

ASS_RegisterPlugin(PLUGIN)
