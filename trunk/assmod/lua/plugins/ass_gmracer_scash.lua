
local PLUGIN = {}

PLUGIN.Name = "Give Cash ( Super Admin )"
PLUGIN.Author = "HuntsKikBut"
PLUGIN.Date = "24th December 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = { "gmod racer" } // only load this plugin for sandbox and it's derivatives

local POWER_TABLE = {
	
	{	Name = "500000",	Cash = 500000	},
	{	Name = "100000",	Cash = 100000	},
	{	Name = "10000",	Cash = 10000	},
	{	Name = "1000",	Cash = 1000	},
	{	Name = "100",	Cash = 100	},
	{	Name = "10",	Cash = 10	},
	{	Name = "-10",	Cash = -10	},
	{	Name = "-100",	Cash = -100	},
	{	Name = "-1000",	Cash = -1000	},
	{	Name = "-10000",	Cash = -10000	},
	{	Name = "-100000",	Cash = -100000	},
	{	Name = "-500000",	Cash = -500000	},

	
}

if (SERVER) then

	ASS_NewLogLevel("ASS_GMR_CASH")

	function PLUGIN.GrantCash(PLAYER, CMD, ARGS)

		if (PLAYER:HasLevel(1)) then
		
			if (ARGS[1]) and (ARGS[2]) then

				local TO_CLEAN = ASS_FindPlayer(ARGS[1])

				if (!TO_CLEAN) then
					ASS_MessagePlayer(PLAYER, "Player not found!\n")
					return

				end
				
				TO_CLEAN:AddCash(tonumber(ARGS[2]));
				
				if tonumber(ARGS[2]) > 1000 then
					PLAYER:PrintMessage(HUD_PRINTTALK, "Console: DO I SEE AN ABUSER????");
				end
				
				SendLog(PLAYER:Nick(), "GIVE_GMR_CASH", TO_CLEAN:Nick(), ARGS[2])

			else
			
				ASS_MessagePlayer(PLAYER, "Player not found!\n")
			
			end

		else

			// Player doesn't have enough access.
			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end
	end
	concommand.Add("ASS_GrantCash", PLUGIN.GrantCash)
	
end

if (CLIENT) then


	function PLUGIN.GiveCash(PLAYER, CASH)
		if (type(PLAYER) == "table") then
			for _, ITEM in pairs(PLAYER) do
				if (ValidEntity(ITEM)) then
					RunConsoleCommand( "ASS_GrantCash", ITEM:UniqueID(), CASH )
				end
			end
		else
			if (!PLAYER:IsValid()) then return end
			RunConsoleCommand( "ASS_GrantCash", PLAYER:UniqueID(), CASH )
		end
	end

	
	function PLUGIN.SlapPower(MENU, PLAYER)

		for k,v in pairs(POWER_TABLE) do
			MENU:AddOption( v.Name,	function() return PLUGIN.GiveCash(PLAYER, v.Cash) end )
		end

	end

	function PLUGIN.AddGamemodeMenu(DMENU)			

		DMENU:AddSubMenu( "Give Cash ( Super Admin )", nil, 
			function(NEWMENU)
				ASS_PlayerMenu(NEWMENU, {"IncludeAll", "HasSubMenu", "IncludeLocalPlayer"}, PLUGIN.SlapPower);
			end )

	end
	
end


ASS_RegisterPlugin(PLUGIN)
