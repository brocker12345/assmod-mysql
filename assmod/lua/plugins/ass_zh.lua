
local PLUGIN = {}

PLUGIN.Name = "Next Level"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "24th December 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = { "zombie horde" } // only load this plugin for sandbox and it's derivatives

if (SERVER) then

	function PLUGIN.NextLevel(PLAYER, CMD, ARGS)

		if (PLAYER:HasLevel(2)) then

			local OurNum = 0;
			for k, v in pairs(GAMEMODE.MapOrder) do
				if v == game.GetMap() then
					OurNum = k;
					break;
				end
			end

			local ShouldBeMap = OurNum + 1;
			
			if ShouldBeMap == 15 then ShouldBeMap = 1; end
			
			RunConsoleCommand("changelevel", GAMEMODE.MapOrder[ShouldBeMap]);

		else

			// Player doesn't have enough access.
			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end
	end
	concommand.Add("ASS_NextLevel", PLUGIN.NextLevel)
	
end

if (CLIENT) then


	function PLUGIN.AddGamemodeMenu(DMENU)			

		DMENU:AddOption("Next Level", function ( ) RunConsoleCommand("ASS_NextLevel", "1") end);
			


	end
	
end


ASS_RegisterPlugin(PLUGIN)
