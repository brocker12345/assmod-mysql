local AchievementName = "GMod Racer: Road Rage";
local AchievementDesc = "Kill 20 people with your buggy in GMod Racer.";
local AchievementImag = "pe_achievements/gmr_roadkill";
local Target = 20;

if SERVER then
	function GivePlayerKill_RoadRage ( v )
		if GAMEMODE.Name == "GMod Racer" then
			if v:GetTable().PEAchievements[AchievementName].Number < Target then
				PEAchievements.Update(v, AchievementName, 1);
			end
		end
	end
end

PEAchievements.Register(AchievementName, AchievementDesc, AchievementImag, Target)
