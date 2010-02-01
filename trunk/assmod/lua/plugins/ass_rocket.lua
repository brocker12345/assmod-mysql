
local PLUGIN = {}

PLUGIN.Name = "Rocket"
PLUGIN.Author = "_Undefined"
PLUGIN.Date = "17th March 2008"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (SERVER) then

	ASS_NewLogLevel("ASS_ACL_ROCKET")

	function PLUGIN.RocketPlayer( PLAYER, CMD, ARGS )

		if (PLAYER:IsTempAdmin()) then

			local TO_ROCKET = ASS_FindPlayer(ARGS[1])

			if (!TO_ROCKET) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end

			if (TO_ROCKET != PLAYER) then
				if (TO_ROCKET:IsBetterOrSame(PLAYER)) then

					// disallow!
					ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_ROCKET:Nick() .. "\" has same or better access then you.")
					return
				end
			end
			
			if (ASS_RunPluginFunction( "AllowPlayerRocket", true, PLAYER, TO_ROCKET )) then

				// Actually Rocket the player
  
				function TO_ROCKET:Rocket() 
  
					TO_ROCKET:SetVelocity(Vector(0, 0, 2048))
	
					timer.Simple(3, function()
					local Position = TO_ROCKET:GetPos()
		
					local Effect = EffectData()
				
					Effect:SetOrigin(Position)
					Effect:SetStart(Position)
					Effect:SetMagnitude(512)
					Effect:SetScale(128)
			
					util.Effect("Explosion", Effect)
					TO_ROCKET:Kill()
					end)
				end

				TO_ROCKET:Rocket()

				ASS_LogAction( PLAYER, ASS_ACL_Rocket, "Rocketed " .. ASS_FullNick(TO_ROCKET) )
					
			end


		else

			// Player doesn't have enough access.
			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end

	end
	concommand.Add("ASS_RocketPlayer", PLUGIN.RocketPlayer)

end

if (CLIENT) then

	function PLUGIN.RocketPlayer(PLAYER)

		// Pretty simple. All we do is fire off a console command.
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "ASS_RocketPlayer", PLAYER:UniqueID() )

	end
	
	function PLUGIN.BuildMenu(NEWMENU)
		
		ASS_PlayerMenu( NEWMENU, {"IncludeLocalPlayer", "IncludeAll"}, PLUGIN.RocketPlayer  ) 
	end

	function PLUGIN.AddMenu(DMENU)
		
		DMENU:AddSubMenu( "Rocket" , nil, PLUGIN.BuildMenu)

	end

end

ASS_RegisterPlugin(PLUGIN)


