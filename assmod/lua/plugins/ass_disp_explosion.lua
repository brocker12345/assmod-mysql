
local PLUGIN = {}

PLUGIN.Name = "Toggle Explosions"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "24th December 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = { "gmod racer" } // only load this plugin for sandbox and it's derivatives

if (SERVER) then

	ASS_NewLogLevel("ASS_GMR_TOGGLE_EXP")

	function PLUGIN.ToggleExp(PLAYER, CMD, ARGS)

		if (PLAYER:HasLevel(1)) then

			if !ARGS[1] then
				ASS_MessagePlayer( PLAYER, "Argument #1 not found.\n" );
			else
				if CMD == "ASS_ToggleExp" then
					if tonumber(ARGS[1]) == 1 then
						GAMEMODE.AllowVehicleDebris = true;
						SendLog(PLAYER:Nick(), "TOGGLE_EXPLOSIONS", nil, "Enabled")
					else
						GAMEMODE.AllowVehicleDebris = false;
						SendLog(PLAYER:Nick(), "TOGGLE_EXPLOSIONS", nil, "Disabled")
					end
				elseif CMD == "ASS_ToggleCarParts" then
					if tonumber(ARGS[1]) == 1 then
						GAMEMODE.SpawnCarParts = true;
						SendLog(PLAYER:Nick(), "TOGGLE_PARTS", nil, "Enabled")
					else
						GAMEMODE.SpawnCarParts = false;
						SendLog(PLAYER:Nick(), "TOGGLE_PARTS", nil, "Disabled")
					end
				else
					if tonumber(ARGS[1]) == 1 then
						GAMEMODE.AllowTestVehicle = true;
						SendLog(PLAYER:Nick(), "TOGGLE_TEST_VEHICLES", nil, "Enabled")
					else
						GAMEMODE.AllowTestVehicle = false;
						SendLog(PLAYER:Nick(), "TOGGLE_TEST_VEHICLES", nil, "Disabled")
					end
				end
				
			end

		else

			// Player doesn't have enough access.
			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end
	end
	concommand.Add("ASS_ToggleExp", PLUGIN.ToggleExp)
	concommand.Add("ASS_ToggleCarParts", PLUGIN.ToggleExp)
	concommand.Add("ASS_ToggleTestVehicles", PLUGIN.ToggleExp)
	
end

if (CLIENT) then


	function PLUGIN.Enable(PLAYER, CASH)
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

	function PLUGIN.AddGamemodeMenu(DMENU)			

		DMENU:AddSubMenu( "Toggle Explosions", nil, 
			function(NEWMENU)
				NEWMENU:AddOption("Enable", function ( ) RunConsoleCommand("ASS_ToggleExp", "1") end);
				NEWMENU:AddOption("Disable", function ( ) RunConsoleCommand("ASS_ToggleExp", "0") end);
			end )
			
		DMENU:AddSubMenu( "Toggle Car Parts", nil, 
			function(NEWMENU)
				NEWMENU:AddOption("Enable", function ( ) RunConsoleCommand("ASS_ToggleCarParts", "1") end);
				NEWMENU:AddOption("Disable", function ( ) RunConsoleCommand("ASS_ToggleCarParts", "0") end);
			end )
			
		DMENU:AddSubMenu( "Toggle Test Vehicles", nil, 
			function(NEWMENU)
				NEWMENU:AddOption("Enable", function ( ) RunConsoleCommand("ASS_ToggleTestVehicles", "1") end);
				NEWMENU:AddOption("Disable", function ( ) RunConsoleCommand("ASS_ToggleTestVehicles", "0") end);
			end )

	end
	
end


ASS_RegisterPlugin(PLUGIN)
