
local PLUGIN = {}

PLUGIN.Name = "Default Writer"
PLUGIN.Author = "Andy Vincent"
PLUGIN.Date = "09th August 2007"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}
PLUGIN.GoodChars = {"a" , "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "@", "^", "=", "_", "-", "~", "[", "]", "{", "}", "'", '"', ":", ", ", ".", "*", "?", "&", "|", "ï", "¢", "£", "¤", "¥", "§", "¦", "«", "ª", "©", "¨", "¬", "­", "®", "¯", "°", "±", "²", "³", "´", "µ", "¶", "·", "¸", "º", "»¼", "½", "¾", "¿", "À", "Á", "Â", "Ã", "Ä", "Å", "Æ", "Ç", "È", "É", "Ê", "Ë", "Ì", "Í", "Î", "Ï", "Ð", "Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "×", "Ø", "Ù", "Ú", "Û", "Ü", "Ý", "Þ", "ß", "à", "á", "â", "ã", "ä", "å", "æ", "ç", "è", "é", "ê", "ë", "ì", "í", "î", "ï", "ñ", "ò", "ó", "ô", "õ", "ö", "÷", "ø", "ù", "ú", "û", "ü", "ý", "þ", "ÿ", "Ð", "Œ", "œ", "Š", "š", "ß", "µ"}

local ASS_AUTOBANNAMES = {'CZ', '51st', 'chrisaster', "=PB=", 'DU', 'Ranger Rick', 'pcwizdan', 'X1L3D'}

function PLUGIN.AddToLog(PLAYER, ACL, ACTION)

	if (ASS_Config["writer"] != PLUGIN.Name) then return end
	
	local fn = "asslog/" .. ACL .. ".txt"
	local log = ""
	
	if (file.Exists(fn)) then
		log = file.Read(fn)
		
		if (#log > 80000) then
			log = "Logs cleared!\n"
		end
	end
	
	log = log .. ASS_FullNick(PLAYER) .. " -> " .. ACTION .. "\n"
	
	file.Write(fn, log)

end
	
function StripForHTTP ( Name, Stop )
	if !Name then return "NA"; end

	Name = mysql.escape(SiteDatabaseConnection, Name);
	
	/*
	
	Name = string.gsub(Name, " ", "_");
	Name = string.gsub(Name, "#", "?");
	
	if !Stop then
		Name = string.gsub(Name, ":", "?");
	end
	
	for i = 1, string.len(Name) do
		local Found = false;
		local Checking = string.sub(Name, i, i)
		
		for k, v in pairs(PLUGIN.GoodChars) do
			if Checking == v then
				Found = true;
				break;
			end
		end
		
		if !Found then
			Name = string.sub(Name, 0, i - 1) .. "?" .. string.sub(Name, i + 1);
		end
	end
	
	*/
		
	return tostring(Name);
end

function SendLog ( ADMIN, TYPE, INFO, OPTIONAL )	
	if !ADMIN then ADMIN = "NA"; end
	if !TYPE then TYPE = "NA"; end
	if !INFO then INFO = "NA"; end
	if !OPTIONAL then OPTIONAL = "NA"; end
	
	if TYPE == "player_say" or TYPE == "player_say_team" then return false; end
		
	local ADMIN = StripForHTTP(ADMIN);
	local TYPE = StripForHTTP(TYPE);
	local INFO = StripForHTTP(INFO);
	local OPTIONAL = StripForHTTP(OPTIONAL);
	local HOSTNAME = StripForHTTP(GetConVarString("hostname"));
	local TIME = os.time();
	
	MySQLQuery(SiteDatabaseConnection, "INSERT INTO `logs` (`TYPE`, `TIME`, `INFO`, `ADMIN`, `OPTIONAL`, `SERVER`) VALUES ('" .. TYPE .. "', '" .. TIME .. "', '" .. INFO .. "', '" .. ADMIN .. "', '" .. OPTIONAL .. "', '" .. HOSTNAME .. "')");
end

function PLUGIN.LoadRankings()
	/*
	
	local rt = ASS_GetRankingTable()
	local ranks = file.Read("ass_rankings.txt")
		
	if ranks and ranks != ", " then
		
		local ranktable = util.KeyValuesToTable(ranks)
		
		for k,v in pairs(ranktable) do
			if v.rank and v.rank == 255 then
				rt[v.id] = {}
				rt[v.id].Rank = v.rank
				rt[v.id].Name = v.name
				rt[v.id].PluginValues = v.pluginvalues or {}
				rt[v.id].UnbanTime = v.unbantime
			end
		end
		
	end
	
	*/
end

function PLUGIN.SaveRankings()

	/*
	
	if (ASS_Config["writer"] != PLUGIN.Name) then return end

	local rt = ASS_GetRankingTable()
	local ranktbl = {}
	
	for k,v in pairs(rt) do

		if (v.Rank != ASS_LVL_GUEST || table.Count(v.PluginValues) != 0) then
	
			local r = {}
			r.Name = v.Name
			r.Rank = v.Rank
			r.Id = k
			r.PluginValues = {}
			r.UnbanTime = v.UnbanTime
			for nm,val in pairs(v.PluginValues) do
				r.PluginValues[nm] = tostring(val)
			end
			table.insert(ranktbl, r)

		end
	
	end

	local ranks = util.TableToKeyValues( ranktbl )
	file.Write("ass_rankings.txt", ranks)
	
	*/
end

ASS_RegisterPlugin(PLUGIN)
ASS_VIPOnlySlots = {};

function PLUGIN.DelayRegister ( Player )
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return false; end

	if !SiteDatabaseConnection then
		Player:PrintMessage(HUD_PRINTTALK, "MySQL Connection Error - Unable to Contact Remote Database - Please Contact Administration");
		return false;
	end
	
	if !gatekeeper then	
		local CheckBans, Success, Error = MySQLQuery(SiteDatabaseConnection, "SELECT `UNBAN` FROM `bans` WHERE `ID`='" .. StripForHTTP(Player:SteamID()) .. "'", mysql.QUERY_FIELDS);
		
		if Success and #CheckBans != 0 then
			UnbanTime = tonumber(CheckBans[1]['UNBAN']);
					
			if UnbanTime == 0 then
				Player:Kick("You are permanently banned from all 0m3ga servers.");
				SendLog("Auto Kicker", "GLOBAL_BAN", Player:Nick(), nil)
				return false;
			elseif UnbanTime < os.time() then
				MySQLQuery(SiteDatabaseConnection, "DELETE FROM `bans` WHERE `ID`='" .. StripForHTTP(Player:SteamID()) .. "'");
			elseif UnbanTime >= os.time() then
				local TimeLeft = UnbanTime - os.time();
				local FormattedTime = string.FormattedTime(UnbanTime - os.time());
				
				local Minutes = math.floor(TimeLeft / 60);
				local Minutes2 = math.floor(TimeLeft / 60);
				local Seconds = TimeLeft - (Minutes * 60);
				local Hours = math.floor(Minutes / 60);
				local Minutes = Minutes - (Hours * 60);
				local Days = math.floor(Hours / 24);
				local Hours = Hours - (Days * 24);
				
				if Minutes2 > 0 then
					RunConsoleCommand("banid", tostring(math.floor(Minutes2)), Player:UserID());
				end
				
				if Minutes == 0 then
					Player:Kick("Banned. Lifted In: " .. Seconds + 1 .. " Seconds");
				elseif Hours == 0 then
					Player:Kick("Banned. Lifted In: " .. Minutes + 1 .. " Minutes");
				elseif Days == 0 then
					Player:Kick("Banned. Lifted In: " .. Hours + 1 .. " Hours");
				else
					Player:Kick("Banned. Lifted In: " .. Days + 1 .. " Days");
				end
				
				SendLog("Auto Kicker", "GLOBAL_BAN", Player:Nick(), nil)
				return false;
			end
		elseif !Success then
			Player:Kick("There is an error in the banning system. Contact administration.");
		end
		
		for k, v in pairs(ASS_AUTOBANNAMES) do
			if string.find(Player:Nick(), v) then
				MySQLQuery(SiteDatabaseConnection, "INSERT INTO `bans` (`ID`, `NAME`, `UNBAN`, `BANNER`, `REASON`) VALUES ('" .. StripForHTTP(Player:SteamID()) .. "', '" .. StripForHTTP(Player:Nick()) .. "', '0', 'Auto-Banner', '" .. StripForHTTP('Name Auto-Ban [' .. v .. ']') .. "')");
				
				RunConsoleCommand("banid", "0", Player:UserID());
				Player:Kick("Your clan is permanently banned from all 0m3ga servers.");
				SendLog("Auto Kicker", "GLOBAL_BAN", Player:Nick(), nil)
			end
		end
	end
	
	local CheckUsers, Success, Error = MySQLQuery(SiteDatabaseConnection, "SELECT `RANK` FROM `users` WHERE `ID`='" .. StripForHTTP(Player:SteamID()) .. "'", mysql.QUERY_FIELDS);
		
	if Success and #CheckUsers != 0 and CheckUsers[1]['RANK'] and tonumber(CheckUsers[1]['RANK']) < 5 then
		GAMEMODE.SetTeam(Player, tonumber(CheckUsers[1]['RANK']))
		Player:SetLevel(tonumber(CheckUsers[1]['RANK']));
	elseif Success then
		GAMEMODE.SetTeam(Player, 5);
	elseif !Success then
		Player:Kick("Unanble to validate UserID. Contact administration.");
	end
end

function PLUGIN.StartDelayRegister ( Player )
	timer.Simple(.25, PLUGIN.DelayRegister, Player);
	
	PLUGIN.DelayRegister(Player);
end

hook.Add("PlayerInitialSpawn", "RegisterNewUsers", PLUGIN.StartDelayRegister);

