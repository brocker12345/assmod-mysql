
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

	local function PerformBlacklist ( TEAM, PLAYER )
		if !PLAYER or !PLAYER:IsValid() or !PLAYER:IsPlayer() then return false; end
		
		local function SendInfo ( Info ) 
			if PLAYER and PLAYER:IsValid() and PLAYER:IsPlayer() then
				RunConsoleCommand('perp_bl', TEAM, PLAYER:UniqueID(), Info);
			end
		end
		
		Derma_StringRequest('Blacklist Reason', 'Why are you blacklisting this person?', '', SendInfo);
	end

	function PLUGIN.DoBlacklist(MENU, PLAYER)
		
		MENU:AddOption( 'Serious RP',	function() PerformBlacklist(999, PLAYER) end )
		MENU:AddOption( 'Mayor',	function() PerformBlacklist(TEAM_MAYOR, PLAYER) end )
		MENU:AddOption( 'Police',	function() PerformBlacklist(TEAM_POLICE, PLAYER) end )
		MENU:AddOption( 'Fireman',	function() PerformBlacklist(TEAM_FIREMAN, PLAYER) end )
		MENU:AddOption( 'Paramedic',	function() PerformBlacklist(TEAM_PARAMEDIC, PLAYER) end )

	end
	
	function PLUGIN.UndoBlacklist(MENU, PLAYER)
		
		MENU:AddOption( 'Serious RP',	function() return RunConsoleCommand('perp_ubl', 999, PLAYER:UniqueID()) end )
		MENU:AddOption( 'Mayor',	function() return RunConsoleCommand('perp_ubl', TEAM_MAYOR, PLAYER:UniqueID()) end )
		MENU:AddOption( 'Police',	function() return RunConsoleCommand('perp_ubl', TEAM_POLICE, PLAYER:UniqueID()) end )
		MENU:AddOption( 'Fireman',	function() return RunConsoleCommand('perp_ubl', TEAM_FIREMAN, PLAYER:UniqueID()) end )
		MENU:AddOption( 'Paramedic',	function() return RunConsoleCommand('perp_ubl', TEAM_PARAMEDIC, PLAYER:UniqueID()) end )

	end
	
	
	function PLUGIN.AddGamemodeMenu(DMENU)			
	
		DMENU:AddSubMenu( "Blacklist",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer", "HasSubMenu"}, PLUGIN.DoBlacklist ) end ):SetImage( "gui/silkicons/status_offline" )
		DMENU:AddSubMenu( "Un-Blacklist",   nil, function(NEWMENU) ASS_PlayerMenu( NEWMENU, {"IncludeAll", "IncludeLocalPlayer", "HasSubMenu"}, PLUGIN.UndoBlacklist ) end ):SetImage( "gui/silkicons/status_offline" )

	end

end

ASS_RegisterPlugin(PLUGIN)
