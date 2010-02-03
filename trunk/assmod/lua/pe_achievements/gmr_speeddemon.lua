local AchievementName = "GMod Racer: Speed Demon";
local AchievementDesc = "Accelerate to more than 80 MPH.";
local AchievementImag = "pe_achievements/gmr_speeddemon";
local Target = 1;

if SERVER then
	local function Update()
		if GAMEMODE.Name == "GMod Racer" then
			for k, Player in pairs(player.GetAll()) do
				if Player:GetTable().PEAchievements[AchievementName].Number < Target then
					local veh = Player:GetVehicle()			
					
					if veh:IsValid() and veh:WaterLevel() == 0 then
						local Speed = math.Round((veh:GetVelocity():Length() / 17.6) * 10) / 10
						
						if Speed >= 80 then
							PEAchievements.Update(Player, AchievementName, 1)
						end
					end
				end
			end
		end
	end

	timer.Create("GMod Racer: Speed Demon", 1, 0, Update)
end

PEAchievements.Register(AchievementName, AchievementDesc, AchievementImag, Target)
