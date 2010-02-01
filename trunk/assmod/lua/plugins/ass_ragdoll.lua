
local PLUGIN = {}

PLUGIN.Name = "Ragdoll"
PLUGIN.Author = "_Undefined"
PLUGIN.Date = "27th May 2008"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (SERVER) then

	ASS_NewLogLevel("ASS_ACL_RAGDOLL")
	
	function PLUGIN.Ragdoll( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() < 2) then

			local TO_RAGDOLL = ASS_FindPlayer(ARGS[1])
			local ENABLE = tonumber(ARGS[2]) > 0

			if (!TO_RAGDOLL) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (PLAYER != TO_RAGDOLL) then
				if (TO_RAGDOLL:IsBetterOrSame(PLAYER) && ENABLE) then

					// disallow!
					ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_RAGDOLL:Nick() .. "\" has same or better access then you.")
					return
	
				end
			end

			if (ASS_RunPluginFunction( "AllowRagdoll", true, PLAYER, TO_RAGDOLL, ENABLE )) then

				if (ENABLE) then
					rag = ents.Create( "prop_ragdoll" )

					if not rag:IsValid() then return end

					rag:SetModel( TO_RAGDOLL:GetModel() )
					rag:SetKeyValue( "origin", TO_RAGDOLL:GetPos().x .. " " .. TO_RAGDOLL:GetPos().y .. " " .. TO_RAGDOLL:GetPos().z )
					rag:SetAngles(TO_RAGDOLL:GetAngles())
					rag.ply = TO_RAGDOLL
					
					TO_RAGDOLL.curweapons = {}
					for num, weapon in pairs(TO_RAGDOLL:GetWeapons()) do
						TO_RAGDOLL.curweapons[num] = weapon:GetClass()
					end
	
					TO_RAGDOLL:StripWeapons()
					TO_RAGDOLL:DrawViewModel(false)
					TO_RAGDOLL:DrawWorldModel(false)
					TO_RAGDOLL:Spectate(OBS_MODE_CHASE)
					TO_RAGDOLL:SpectateEntity(rag)
					TO_RAGDOLL:Lock()
	
					rag:Spawn()
					rag:Activate()
					
					hook.Add( "CanPlayerSuicide", "NoKill", function() return false end )
					
					ASS_LogAction( PLAYER, ASS_ACL_RAGDOLL, "ragdolled " .. ASS_FullNick(TO_RAGDOLL) )
				else
					if not rag:IsValid() then return end
					
					TO_RAGDOLL:SetModel( rag:GetModel() )
					TO_RAGDOLL:SetAngles( rag:GetAngles() )
					rag:Remove()
					TO_RAGDOLL:DrawViewModel(true)
					TO_RAGDOLL:DrawWorldModel(true)
					TO_RAGDOLL:UnSpectate()
					TO_RAGDOLL:UnLock()
					TO_RAGDOLL:Spawn()
					TO_RAGDOLL:SetPos( rag:GetPos() + Vector(0, 0, 100) )
					TO_RAGDOLL:SetVelocity(TO_RAGDOLL:GetPhysicsObject():GetVelocity())
					
					for num, weapon in pairs(TO_RAGDOLL.curweapons) do
						TO_RAGDOLL:Give(weapon)
					end
					
					hook.Add( "CanPlayerSuicide", "NoKill", function() return true end )
					
					ASS_LogAction( PLAYER, ASS_ACL_RAGDOLL, "unragdolled " .. ASS_FullNick(TO_RAGDOLL) )
				end
				
			end

		end

	end
	concommand.Add("ASS_Ragdoll", PLUGIN.Ragdoll)

end

if (CLIENT) then

	function PLUGIN.Ragdoll(PLAYER, ALLOW)

		// Check if PLAYER is actually a table, or a player.
		// If it's a table, run the console command for each
		// player.
		
		if (type(PLAYER) == "table") then
			for _, ITEM in pairs(PLAYER) do
				if (ValidEntity(ITEM)) then
					RunConsoleCommand( "ASS_Ragdoll", ITEM:UniqueID(), ALLOW )
				end
			end
		else
			if (!ValidEntity(PLAYER)) then return end
			RunConsoleCommand( "ASS_Ragdoll", PLAYER:UniqueID(), ALLOW )
		end

	end
	
	function PLUGIN.RagdollEnableDisable(MENU, PLAYER)

		// Here if one of the (All Player | All Admins | All Non-Admins) items has been
		// selected, PLAYER is actually a table of players (not an individual player).
		// It doesn't really matter at this stage, since we're just passing it on to an
		// anonymous function (I love anonymous functions <3)
		
		MENU:AddOption( "Enable",	function() PLUGIN.Ragdoll(PLAYER, 1) end )
		MENU:AddOption( "Disable",	function() PLUGIN.Ragdoll(PLAYER, 0) end )

	end

	function PLUGIN.AddMenu(DMENU)			
	
		// Sample usage of the new "IncludeAll" option, with the "HasSubMenu" option.
		// When GodEnableDisable is called from the called from one of the 
		// (All Player | All Admins | All Non-Admins) menus, the PLAYER parameter is
		// actually a table of players to act upon.
		
		DMENU:AddSubMenu( "Ragdoll", nil, 
			function(NEWMENU) 
				ASS_PlayerMenu( NEWMENU, {"IncludeAll", "HasSubMenu","IncludeLocalPlayer"}, PLUGIN.RagdollEnableDisable  ) 
			end
		)

	end

end

ASS_RegisterPlugin(PLUGIN)