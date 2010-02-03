if SERVER then
	AddCSLuaFile("pe_achv.lua");
	resource.AddFile("sound/pe_achv_earn.mp3");
	
	for k, v in pairs(file.Find("../materials/pe_achievements/*.*")) do
		resource.AddFile("materials/pe_achievements/" .. v);
	end
	
	PEAchievements = {};
	PEQueuedTime = 10;
	
	function PEAchievements.Register ( Name, Description, Image, MaximumNumber )
		local NewTable = {};
		NewTable.Name = Name;
		NewTable.Description = Description;
		NewTable.Image = Image;
		NewTable.Number = 0;
		NewTable.MaxNumber = MaximumNumber;
		
		PEAchievements[Name] = NewTable;
	end
	
	function PEAchievements.PlayerJoin ( Player )		
		Player:GetTable().PEAchievements = table.Copy(PEAchievements);
		
		local res, s, e = MySQLQuery(SiteDatabaseConnection, "SELECT * FROM `achievements` WHERE `ID`='" .. Player:SteamID() .. "'", mysql.QUERY_FIELDS);
		
		if res and #res == 0 then
			MySQLQuery(SiteDatabaseConnection, "INSERT INTO `achievements` (`ID`) VALUES ('"..Player:SteamID().."')");
			
			res = MySQLQuery(SiteDatabaseConnection, "SELECT * FROM `achievements` WHERE `ID`='" .. Player:SteamID() .. "'", mysql.QUERY_FIELDS);
		end
		
		timer.Simple(1, 
			function ( )
				if !Player or !Player:IsValid() or !Player:IsPlayer() then return false; end
				for k, v in pairs(res[1]) do
					if Player:GetTable().PEAchievements[k] and v != 0 then
						PEAchievements.Update(Player, k, v, true);
					end
				end
			end
		);
	end
	hook.Add("PlayerInitialSpawn", "PulsarEffectAchievements_InitialSpawn", PEAchievements.PlayerJoin);
	
	function PEAchievements.Update ( Player, Name, NumToAdd, IsLoading )
		if !Player or !Player:IsValid() then return false; end
		if !Player:GetTable().PEAchievements then return false; end
		
		local PTable = Player:GetTable().PEAchievements[Name];
		
		if !PTable then  return false; end
		
		local NewNumber = PTable.Number + NumToAdd;
		
		if !PTable.MaxNumber then  return false; end
		
		if PTable.Number < PTable.MaxNumber and NewNumber >= PTable.MaxNumber and !IsLoading then
			// Congrats!
			for k, v in pairs(player.GetAll()) do
				v:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " unlocked '" .. Name .. "'!");
			end
			
			NewNumber = PTable.MaxNumber;
		elseif PTable.Number >= PTable.MaxNumber then
			// We already have it, why update?
			return false;
		elseif NewNumber > PTable.MaxNumber then
			NewNumber = PTable.MaxNumber;
		end
		
		PTable.Number = NewNumber;
		
		PEQueuedTime = PEQueuedTime + 1;
		
		timer.Simple(PEQueuedTime,
			function ( Player )
				if !Player or !Player:IsValid() then return false; end
				
				PEQueuedTime = PEQueuedTime - 1;
				
				// Msg("Send - " .. CurTime() .. "\n");
				
				umsg.Start("PE_UpdateAchievement", Player);
					umsg.String(Name);
					umsg.Short(PTable.Number);
					umsg.Bool(IsLoading or false);
				umsg.End();
			end
		, Player);
		
		if !IsLoading then
			MySQLQuery(SiteDatabaseConnection, "UPDATE `achievements` SET `" .. Name .. "`='" .. PTable.Number .. "' WHERE `ID`='" .. Player:SteamID() .. "'");
		end
	end
	
	for k, v in pairs(file.FindInLua("pe_achievements/*.lua")) do
		AddCSLuaFile("pe_achievements/" .. v)
		include("pe_achievements/" .. v);
	end
end

if !CLIENT then return false; end

local function PEAchievements_Initialize ( )
	local PEAchievementMenu = vgui.Create( "PEAcievements_Menu" )
	
	PEAchievements = {};
	
	function PEAchievements.ShowMenu ( )
		PEAchievementMenu:InvalidateLayout()
		PEAchievementMenu:SetVisible( true )
	end
	concommand.Add("pe_achievements", PEAchievements.ShowMenu)
	
	function PEAchievements.Sort ( ) PEAchievementMenu:SortAchievements(); end
	function PEAchievements.TotalNumber ( ) return PEAchievementMenu.TotalAchievements or 0; end
	function PEAchievements.Register ( Name, Description, Image, MaximumNumber ) PEAchievementMenu:SetupAchievement(Name, Description, Image, MaximumNumber) end
	function PEAchievements.Update ( Name, Percent, Text ) PEAchievementMenu:UpdateAchievement(Name, Percent, Text) end	
	
	local Files = file.FindInLua( "pe_achievements/*.lua" )
	table.sort(Files)
	for k, v in ipairs(Files) do include("pe_achievements/" .. v) end
	PEAchievements.Sort()
	PEAchievements.FinishedLoading = true

	function PEAchievements.ReceiveUpdate ( UMsg )
		local Name, Number, Loading = UMsg:ReadString(), UMsg:ReadShort(), UMsg:ReadBool();
		
		if !PEAchievementMenu.Achievements[Name] then return false; end
		
		local Percent = Number / PEAchievementMenu.Achievements[Name].MaxNumber;
		
		if Number > PEAchievementMenu.Achievements[Name].MaxNumber then
			Number = PEAchievementMenu.Achievements[Name].MaxNumber;
		end
		
		
		local PercentText = "";
		if PEAchievementMenu.Achievements[Name].MaxNumber > 1 then
			PercentText = Number .. "/" .. PEAchievementMenu.Achievements[Name].MaxNumber;
		end
		
		if Loading then
			PEAchievementMenu.Achievements[Name].Unlocked = Percent >= 1;
		end
				
		PEAchievements.Update(Name, Percent, PercentText);
	end
	usermessage.Hook("PE_UpdateAchievement", PEAchievements.ReceiveUpdate);
end
hook.Add("Initialize", "PEAchievements_Initialize", PEAchievements_Initialize)



local PANEL = {}
function PANEL:Init()
	self:SetTitle( "Pulsar Effect Server Achievements" )
	self:MakePopup()
	self:SetVisible( false )
	self:SetDeleteOnClose( false )
		
	self.Bar = vgui.Create( "PEAchievement_Progress_Total", self )
	self.List = vgui.Create( "DPanelList", self )
	self.List:EnableVerticalScrollbar()
	self.List:SetPadding( 4 )
	self.List:SetSpacing( 4 )
		
	self.CloseB = vgui.Create( "DButton", self )
	self.CloseB:SetText( "Close" )
	self.CloseB.DoClick = function() self:SetVisible( false ) end
		
	self:SetSize( math.floor( ScrW() * 0.6 ), math.floor( ScrH() * 0.6 ) )
	self:Center()
		
	self.Achievements = {}
end
	
function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall()
		
	self.Bar:SetPos( 15, 40 )
	self.Bar:SetSize( w - 30, 50 )
		
	self.List:SetPos( 15, 100 )
	self.List:SetSize( w - 30, h - 140 )
		
	self.CloseB:SetPos( w - 85, h - 34 )
	self.CloseB:SetSize( 70, 24 )
		
	for _, ach in pairs( self.Achievements or {} ) do
		ach.Panel:SetSize( self.List:GetWide() - 18, 64 )
	end
	self.List:InvalidateLayout()
		
	self.BaseClass.PerformLayout( self )
end
	
function PANEL:SortAchievements()
	local tab = {}
	for name, _ in pairs( self.Achievements ) do
		tab[ #tab + 1 ] = name
	end
	table.sort( tab )
	
	self.List:Clear()
	for _, name in pairs( tab ) do
		local info = self.Achievements[ name ]
		if ( info && info.Panel ) then
			self.List:AddItem( info.Panel )
		end
	end
	self:InvalidateLayout()
end
	
function PANEL:SetupAchievement( name, desc, image, maximum )
	percent = 0
	percentText = "";
	
	if maximum > 1 then
		percentText = "0/" .. maximum;
	end
		
	local panel
	if ( self.Achievements[ name ] == nil ) then
		panel = vgui.Create( "PEAchievement_Info", self )
			self.List:AddItem( panel )
		self:InvalidateLayout()
	else
		panel = self.Achievements[ name ].Panel
	end
	self.Achievements[ name ] = { Desc = desc, Image = image, Percent = percent, Panel = panel, MaxNumber = maximum, Unlocked = percent == 1 }
		
	self:UpdateAchievement( name, percent, percentText )
end

function PANEL:UpdateAchievement( name, percent, percentText )
	if ( self.Achievements[ name ] == nil ) then  return false end
				
	local ach = self.Achievements[ name ]
	ach.Percent = percent
	ach.Panel:Setup( name, ach.Desc, ach.Image, percent, percentText )
		
	if ( !ach.Unlocked && percent >= 1 ) then
		local popup = vgui.Create( "PEAachievement_Popup" )
			popup:SetAchievement( name, ach.Image )
		ach.Unlocked = true
			
		if ( GetConVarNumber( "achievements_effect" ) > 0 ) then
			local ed = EffectData()
			ed:SetEntity(LocalPlayer())
			util.Effect("achievement",ed, true, true)
		end
	end
		
	local total = 0
	for _, ach in pairs( self.Achievements ) do
		if ( ach.Percent == 1 ) then total = total + 1 end
	end
	self.Bar:SetEarned( total, table.Count( self.Achievements ) )
		
	self.TotalAchievements = table.Count( self.Achievements )
end
vgui.Register("PEAcievements_Menu", PANEL, "DFrame")



local PANEL = {}
function PANEL:Init()
	self.Name, self.Description, self.Image, self.Percent, self.PercentText = "", "", "", 1, ""
		
	self.LName = vgui.Create( "DLabel", self )
		self.LName:SetFont( "Default14BA" )
		self.LName:SetTextColor( Color( 158, 195, 79 ) )
		self.LName:SetPos( 71, 5 )
			
	self.LDesc = vgui.Create( "DLabel", self )
		self.LDesc:SetFont( "default" )
		self.LDesc:SetTextColor( Color( 217, 217, 217 ) )
		self.LDesc:SetPos( 72, 22 )
		
	self.LPercent = vgui.Create( "DLabel", self )
		self.LPercent:SetFont( "default" )
		self.LPercent:SetTextColor( Color( 210, 210, 210 ) )
		
	self.Bar = vgui.Create( "PEAchievement_Progress", self )
	self.Bar:SetColour( Color( 201, 185, 149 ) )
end

function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall()
	self.Bar:SetPos( 70, h - 22 )
	self.Bar:SetSize( w - 200, 12 )
		
	self.LName:SetSize( w, 15 )
	self.LDesc:SetSize( w, 15 )
		
	self.LPercent:SetSize( w, 15 )
	self.LPercent:SetPos( self.Bar.X + self.Bar:GetWide() + 10, h - 24 )
end
	
function PANEL:Setup( name, desc, image, percent, percentText )
	self.Name, self.Description, self.Image, self.Percent, self.PercentText = name, desc, image or "", percent, percentText or ""
	self.Percent = math.Clamp( self.Percent, 0, 1 )
		
	self.LName:SetText( name )
	self.LDesc:SetText( desc )
	self.LPercent:SetText( percentText or "" )
		
	if ( self.Image != "" ) then
		self.Material = Material( self.Image )
	else
		self.Material = nil
	end
		
	self.Bar:SetVisible( percentText != "" )
	self.Bar:SetPercent( self.Percent )
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
	
	if ( self.Percent == 1 ) then
		draw.RoundedBox( 4, 0, 0, w, h, Color( 78, 78, 78 ) )
	else
		draw.RoundedBox( 4, 0, 0, w, h, Color( 56, 56, 56 ) )
	end
		
	if ( !self.Material ) then return end
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( self.Material )
	surface.DrawTexturedRect( 4, 4, 56, 56 )
end
vgui.Register( "PEAchievement_Info", PANEL )
	
	
	
local PANEL = {}
function PANEL:Init()
	self.Offset = 0
	self.Direction = 1
	self.Speed = 3
	self.Slot = 1
	self.Text = ""
		
	surface.PlaySound( Sound( "pe_achv_earn.mp3" ) )
end

function PANEL:SetAchievement( text, image )
	self.Text = text
	self.Image = image or "pe_achievements/generic"
		
	self.Material = Material( self.Image )
	if ( !self.Material ) then self.Image = nil end
end

function PANEL:SetSlot( slot )
	self.Slot = slot
end
	
function PANEL:Think()
	self.Offset = math.Clamp( self.Offset + ( self.Direction * FrameTime() * self.Speed ), 0, 1 )
	self:InvalidateLayout()
		
	if ( self.Direction == 1 && self.Offset == 1 ) then
		self.Direction = 0
		self.Down = CurTime() + 5
	end
	if ( self.Down != nil && CurTime() > self.Down ) then
		self.Direction = -1
		self.Down = nil
	end
	if ( self.Offset == 0 ) then
		self.Removed = true
	end
end

function PANEL:PerformLayout()
	local w, h = 240, 94
		
	self:SetSize( w, h )
	self:SetPos( ScrW() - w, ScrH() - ( h * self.Offset * self.Slot ) )
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
	local a = self.Offset * 255
		
	surface.SetDrawColor( 47, 49, 45, a )
	surface.DrawRect( 0, 0, w, h )
		
	surface.SetDrawColor( 104, 106, 101, a )
	surface.DrawOutlinedRect( 0, 0, w, h )
		
	surface.SetDrawColor( 255, 255, 255, a )
		
	if ( self.Image ) then
		surface.SetMaterial( self.Material )
		surface.DrawTexturedRect( 14, 14, 64, 64 )
			
		surface.SetDrawColor( 70, 70, 70, a )
		surface.DrawOutlinedRect( 13, 13, 66, 66 )
	end
		
	draw.DrawText( "Achievement Unlocked!", "default", 88, 30, Color( 255, 255, 255, a ), TEXT_ALIGN_LEFT )
	draw.DrawText( self.Text, "default", 88, 46, Color( 216, 222, 211, a ), TEXT_ALIGN_LEFT )
		
end
vgui.Register( "PEAachievement_Popup", PANEL )
	
	
local function ToValues( col )
	if ( !col ) then return 255, 255, 255, 255 end
	return col.r, col.g, col.b, col.a
end


local PANEL = {}
function PANEL:Init()
	self.Percent = 0
	self.Foreground = Color( 255, 255, 255 )
end

function PANEL:SetColour( fore )
	self.Fore = fore
end

function PANEL:SetPercent( percent )
	while ( percent > 1 ) do percent = percent / 100 end
	self.Percent = percent
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
	surface.SetDrawColor( 62, 62, 62, 255 )
	surface.DrawRect( 0, 0, w, h )
		
	surface.SetDrawColor( self.Fore.r, self.Fore.g, self.Fore.b, self.Fore.a )
	surface.DrawRect( 0, 0, w * self.Percent, h )
end
vgui.Register( "PEAchievement_Progress", PANEL )

	
local PANEL = {}
function PANEL:Init()
	self.Text = "0/0"
	self.Percent = 100
		
	self.Bar = vgui.Create( "PEAchievement_Progress", self )
		self.Bar:SetColour( Color( 158, 195, 79 ) )
end

function PANEL:PerformLayout()
	local w, h = self:GetWide(), self:GetTall()
	self.Bar:SetPos( 8, h - 25 )
	self.Bar:SetSize( w - 16, 16 )
end

function PANEL:SetEarned( earned, total )	
	self.Text = earned .. "/" .. total
		
	if ( total > 0 ) then
		self.Percent = math.floor( ( earned / total ) * 100 )
	else
		self.Percent = 0
	end
		
	self.Bar:SetPercent( self.Percent / 100 )
end

function PANEL:Paint()
	local w, h = self:GetWide(), self:GetTall()
		
	surface.SetDrawColor( 26, 26, 26, 255 )
	surface.DrawRect( 0, 0, w, h )
		
	draw.SimpleText( "Achievements Earned:", "default", 8, 7, Color( 217, 217, 217 ) ) 
	draw.SimpleText( self.Text .. " ( " .. self.Percent .. "% )", "default", w - 10, 7, Color( 217, 217, 217 ), TEXT_ALIGN_RIGHT ) 
end
vgui.Register( "PEAchievement_Progress_Total", PANEL )


	
	
	
	
	
