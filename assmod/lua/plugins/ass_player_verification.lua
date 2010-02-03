local PLUGIN = {}

PLUGIN.Name = "Default Writer2ds"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "09th August 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if !SERVER then return false; end

require("gatekeeper")

local ASS_AUTOBANNAMES = {'CZ', '51st', 'chrisaster', "=PB=", 'DU'}

local function JoinAuth ( Name, Pass, SteamID, IP )	
	Msg('Gatekeeper: ' .. Name .. ' joined with IP ' .. IP .. '\n');
	
	if SinglePlayer() then return end

	if !SiteDatabaseConnection then
		return {false, "MySQL Connection Error - Contact Administration"}
	end
	
	local CheckBans, Success, Error = MySQLQuery(SiteDatabaseConnection, "SELECT `UNBAN` FROM `bans` WHERE `ID`='" .. SteamID .. "'", mysql.QUERY_FIELDS);
	
	if !Success then
		return {false, "MySQL Connection Error - Contact Administration"}
	end
	
	if #CheckBans != 0 then
		local Time = os.time();
		local UnbanTime = tonumber(CheckBans[1]['UNBAN']);
	
		if UnbanTime == 0 then
			return {false, "You are permanently banned from all 0m3ga servers."};
		elseif UnbanTime < Time then
			MySQLQuery(SiteDatabaseConnection, "DELETE FROM `bans` WHERE `ID`='" .. SteamID .. "'");
		elseif UnbanTime >= Time then
			local TimeLeft = UnbanTime - os.time();
			local FormattedTime = string.FormattedTime(UnbanTime - os.time());
			
			local Minutes = math.floor(TimeLeft / 60);
			local Minutes2 = math.floor(TimeLeft / 60);
			local Seconds = TimeLeft - (Minutes * 60);
			local Hours = math.floor(Minutes / 60);
			local Minutes = Minutes - (Hours * 60);
			local Days = math.floor(Hours / 24);
			local Hours = Hours - (Days * 24);
			
			if Minutes == 0 then
				return {false, "Banned. Lifted In: " .. Seconds + 1 .. " Seconds"};
			elseif Hours == 0 then
				return {false, "Banned. Lifted In: " .. Minutes + 1 .. " Minutes"};
			elseif Days == 0 then
				return {false, "Banned. Lifted In: " .. Hours + 1 .. " Hours"};
			else
				return {false, "Banned. Lifted In: " .. Days + 1 .. " Days"};
			end
		end
	end

	for k, v in pairs(ASS_AUTOBANNAMES) do
		if string.find(Name, v) then
			MySQLQuery(SiteDatabaseConnection, "INSERT INTO `bans` (`ID`, `NAME`, `UNBAN`, `BANNER`, `REASON`) VALUES ('" .. SteamID .. "', '" .. Name .. "', '0', 'Auto-Banner', '" .. StripForHTTP('Name Auto-Ban [' .. v .. ']') .. "')");
			
			return {false, "Your clan is banned from all 0m3ga servers."};
		end
	end
	
	if MaxPlayers() == 41 then
		local RPData = MySQLQuery(SiteDatabaseConnection, "SELECT `blacklist`, `time_played` FROM `rp_users` WHERE `steamid`='" .. SteamID .. "'", mysql.QUERY_FIELDS);
		
		if RPData and RPData[1] and RPData[1]['blacklist'] then
			local BL = RPData[1]['blacklist'];
			
			if BL != '' then
				return {false, "You have been blacklisted from the serious RP server."};
			end
			
			local TP = tonumber(RPData[1]['time_played'])
			
			//if 60 * 60 * 3 > TP then
			//	return {false, "3 hours playtime on PERP Lite required to play on Serious."};
			//end
		//else
			//return {false, "3 hours playtime on PERP Lite required to play on Serious."};
		end
	end
	
	local CheckUsers, Success, Error = MySQLQuery(SiteDatabaseConnection, "SELECT `RANK` FROM `users` WHERE `ID`='" .. SteamID .. "'", mysql.QUERY_FIELDS);
	
	if !Success then
		return {false, "MySQL Connection Error - Contact Administration"}
	end
	
	local IsVIP = false;
	
	if #CheckUsers != 0 and CheckUsers[1]['RANK'] and tonumber(CheckUsers[1]['RANK']) < 5 then
		IsVIP = true;
		Msg(Name .. ' is a VIP...\n');
	end
	
	if table.Count(player.GetAll()) >= MaxPlayers() then
		Msg('Server full... kicking non-vip.\n');
		
		if !IsVIP then
			return {false, "This slot is reserved for VIPs."};
		end
		
		local HighestJoinTime = 0;
		local HighestJoinTime_Player;
		
		for k, v in pairs(player.GetAll()) do
			if v:GetLevel() == 5 and v:TimeConnected() > HighestJoinTime then
				HighestJoinTime = v:TimeConnected();
				HighestJoinTime_Player = v;
			end
		end
		
		if !HighestJoinTime_Player or !HighestJoinTime_Player:IsValid() or !HighestJoinTime_Player:IsPlayer() then
			return {false, "VIP Reserved Slot Error - Contact Administration."};
		end
		
		gatekeeper.Drop(HighestJoinTime_Player:UserID(), "Kicked to make room for VIP reserved slot.")
	end
	
	return
end
hook.Add("PlayerPasswordAuth", "PlayerAuthentication", JoinAuth)

ASS_RegisterPlugin(PLUGIN)