
local PLUGIN = {}

PLUGIN.Name = "Reset Skills"
PLUGIN.Author = "HuntsKikBut"
PLUGIN.Date = "21st September 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = { "perp" } // only load this plugin for sandbox and it's derivatives

if (CLIENT) then

	function PLUGIN.DoBlacklist(PLAYER)
		local function EndFunction ( Info )
			if PLAYER and PLAYER:IsValid() and PLAYER:IsPlayer() then
				RunConsoleCommand('perp_demote', PLAYER:UniqueID(), Info);
			end
		end

		Derma_StringRequest("Demote Reason", "Why are you demoting this person?", "", EndFunction);
	end
	
	
	function PLUGIN.AddGamemodeMenu(DMENU)			
	
		DMENU:AddSubMenu( "Demote",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer"}, PLUGIN.DoBlacklist ) end ):SetImage( "gui/silkicons/status_offline" )

	end

end

ASS_RegisterPlugin(PLUGIN)
