local AchievementName = "GMod Racer: Destruction Derby";
local AchievementDesc = "Be killed 100 times while you're racing.";
local AchievementImag = "pe_achievements/gmr_destructionderby";
local Target = 100;

if SERVER then
	function GivePlayerKill_DestructionDerby ( v )
		if GAMEMODE.Name == "GMod Racer" then
			if v:GetTable().PEAchievements[AchievementName].Number < Target then
				PEAchievements.Update(v, AchievementName, 1);
			end
		end
	end
end

PEAchievements.Register(AchievementName, AchievementDesc, AchievementImag, Target)
