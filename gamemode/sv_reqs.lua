if !MySQLLoaded then require("mysql"); MySQLLoaded = true; end

function GM.ConnectToMySQL()
	SiteDatabaseConnection, MySQLError = mysql.connect("host", "username", "password", "database", 3306);

	if SiteDatabaseConnection == 0 then
		if !file.Exists("mysql_fail_log.txt") then file.Write("mysql_fail_log.txt", ""); end
		file.Write("mysql_fail_log.txt", file.Read("mysql_fail_log.txt") .. "MySQL connection failed with reason '" .. MySQLError .. "'\n");
		RunConsoleCommand("sv_password", "error");
		RunConsoleCommand("hostname", "MySQL Connection Failure");

		for k, v in pairs(player.GetAll()) do
			RunConsoleCommand("kickid", v:UserID(), "MySQL Connection Error");
		end
		
		timer.Create("sqlretry",10,1,GM.RetrySQLConnection);
		
		return false;
	else
		Msg("Successfully connected to MySQL database.\n");
	end
end

function GM.RetrySQLConnection()
	SiteDatabaseConnection, MySQLError = mysql.connect("host", "username", "password", "database", 3306);

	if SiteDatabaseConnection == 0 then
		if !file.Exists("mysql_reconnect_fail_log.txt") then file.Write("mysql_fail_log.txt", ""); end
		file.Write("mysql_reconnect_fail_log.txt", file.Read("mysql_fail_log.txt") .. "MySQL connection failed with reason '" .. MySQLError .. "'\n");
		
		timer.Destroy("sqlretry")
		timer.Create("sqlretry",10,1,GM.RetrySQLConnection);
		
		return false;
	else
		Msg("Successfully connected to MySQL database after a failure.\n");
		RunConsoleCommand("sv_password", "");
		RunConsoleCommand("hostname", "<Server Name>");
		RunConsoleCommand("map", "<map>");
		timer.Destroy("sqlretry");
	end
end

function GM:PlayerNoClip ( Player )
	if Player:GetLevel() <= 1 then
		return true;
	else
		return false;
	end
end

if !SiteDatabaseConnection then GM.ConnectToMySQL() end

function GM.SetTeam ( Player, Hint )
	Player:SetTeam(Hint);
end

RunConsoleCommand('mp_falldamage', '1');
RunConsoleCommand('lua_log_sv', '1');
/*RunConsoleCommand('sv_downloadurl', 'http://awebsite.com/fast_dl/');
RunConsoleCommand("sv_allowdownload", "1");
RunConsoleCommand("sv_allowupload", "1");
RunConsoleCommand('net_maxfilesize', '64');
*/
RunConsoleCommand('sv_alltalk', '0');
RunConsoleCommand('hostname', '<server name>');

function GM:PlayerConnect ( Name, Address, SteamID )
	if !Go then
		Go = true;
		file.Write('ip_log.txt', '');
	end
	
	file.Write('ip_log.txt', file.Read('ip_log.txt') .. math.Round(CurTime()) .. ' : ' .. tostring(Name) .. ' -> ' .. tostring(Address) .. ' -> ' .. tostring(SteamID) .. '\n')
end