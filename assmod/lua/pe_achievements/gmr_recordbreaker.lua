local AchievementName = "GMod Racer: Record Breaker";
local AchievementDesc = "Beat a record on GMod Racer.";
local AchievementImag = "pe_achievements/gmr_recordbreaker";
local Target = 1;

if SERVER then
	function PEA_GMR_RecordBreaker ( Player)
		if GAMEMODE.Name == "GMod Racer" then
			PEAchievements.Update(Player, AchievementName, 1)
		end
	end
end

PEAchievements.Register(AchievementName, AchievementDesc, AchievementImag, Target)
