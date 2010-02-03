if !SERVER then return false; end
local PLUGIN = {}

PLUGIN.Name = "Ban Words"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "09th August 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

PLUGIN.BannedWords = {"nigger", "white power", "nigga", "whitepower", "whitpower", "nigg3r", "niggar", "niglet", "n1gger", "n1gg3r", "nlgger", "nlgg3r", "reggin", "n!gger", "n!gg3r", "chrisaster", "retsasirhc", "chink"};

function PLUGIN.MonitorChat ( Player, Text, Bool )
	for k, v in pairs(PLUGIN.BannedWords) do
		if string.find(string.lower(Text), string.lower(v)) then
			if Player:GetLevel() < 4 then
				Player:PrintMessage(HUD_PRINTTALK, "As an Admin, you are immune from the auto-banner, but please watch your language as to avoid aggrivating other players.");
			else
				ASS_ShortBan(Player, 1440, 'Auto Banner', 'Racism Auto-Ban [' .. v .. ']')
				SendLog("Auto Kicker", "GLOBAL_BAN", Player:Nick(), nil)
				
				for l, j in pairs(player.GetAll()) do
					j:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " was banned for saying '" .. v .. "', which is an auto-ban word.");
				end
				
				SendLog("Auto Banner", "AUTO_WORD_BAN", Player:Nick(), v)
				
				return "";
			end
		end
	end
	
	PLUGIN.PlayerLastChats[Player] = CurTime()
end
hook.Add("PlayerSay", "PLUGIN.MonitorChat", PLUGIN.MonitorChat);

PLUGIN.PlayerPositions = {};
PLUGIN.PlayerLastChats = {};
GAMEMODE.EnableAutoKick = true;

if GAMEMODE.Name == 'Risk' then return false; end

function PLUGIN.MonitorPlayerMovement ( )
	if !GAMEMODE.EnableAutoKick then return false; end
	if game.GetMap() == 'risk' then return false; end

	for k, v in pairs(player.GetAll()) do
		PLUGIN.PlayerPositions[v] = PLUGIN.PlayerPositions[v] or Vector(0, 0, 0);
			
		local CurPos = v:GetPos();
			
		PLUGIN.PlayerLastChats[Player] = PLUGIN.PlayerLastChats[Player] or 0;
		
		if Player:GetLevel() < 4 then
			Player:PrintMessage(HUD_PRINTTALK, "As an Admin, you are immune from the auto-kicker.");
		elseif PLUGIN.PlayerPositions[v]:Distance(CurPos) <= 1 then
			v:Kick("AFK");
				
			for l, j in pairs(player.GetAll()) do
				j:PrintMessage(HUD_PRINTTALK, v:Nick() .. " was kicked for being AFK.");
			end
				
			SendLog("Auto Kicker", "AUTO_AFK_KICK", v:Nick(), nil)
		else
			PLUGIN.PlayerPositions[v] = CurPos;
		end
	end
end
timer.Create("PLUGIN.MonitorPlayerMovement", 600, 0, PLUGIN.MonitorPlayerMovement);