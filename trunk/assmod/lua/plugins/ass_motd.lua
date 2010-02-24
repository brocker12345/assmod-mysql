
local PLUGIN = {}

PLUGIN.Name = "ASSmod MOTD v2"
PLUGIN.Author = "PC Camp EDITED BY Cj"
PLUGIN.Date = "May, NOV, 2008"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if CLIENT then
/*====================================================
================== CONFIGURATION =====================
====================================================*/

	ASSMOTD_TimeToWait = 5 -- The time needed until the player can exit the MOTD in seconds

end --<<<<<-----<<<<< NOT a part of CONFIGURATION. DO NOT EDIT!!!

if (SERVER) then --<<<<<-----<<<<< NOT a part of CONFIGURATION. DO NOT EDIT!!!

	-- ONLY EDIT THE FOLLOWING IF YOU ARE DOING A FRESH INSTALL OF THIS PLUGIN
	-- Check and see if there is a folder in your data folder called "ASSmod"
	-- The directory of the saved MOTD is "garrysmod/data/ASSmod/motd.txt"
	-- If that file exists, the HTML below us will not be ran
	ASSMOTD_HTMLScript = [[
	<html>

<style type="text/css">
<!--
body,td,th {
	font-family: Palatino Linotype, Book Antiqua, Palatino, serif;
}
.ghfghfg {
	font-family: Verdana, Geneva, sans-serif;
}
.omega {
	font-family: MS Serif, New York, serif;
}
.omega {
	font-family: Verdana, Geneva, sans-serif;
}
.omega {
	font-family: Verdana, Geneva, sans-serif;
}
.omega {
	color: #F00;
}
body div div div font font font {
	color: #800000;
}
body div div {
	color: #800040;
}
body div div {
	color: #800040;
}
body div div {
	color: #800040;
}
body div div p strong {
	color: #008080;
}
body div div p em {
	color: #008080;
}
body div div {
	color: #800000;
}
body div div p {
	color: #800000;
}
body div div ul {
	color: #400000;
}
body div div p font font font center {
	color: #800000;
}
body div div ul font strong center {
	color: #238AD6;
}
body div div p font strong center {
	color: #238AD6;
}
body div div p font strong center p {
	color: #238AD6;
}
body div div p font font font center {
	color: #238AD6;
}
-->
</style><body bgcolor=#dbdbdb>
<div style="text-align: center;">
  <div style="width: 80%; margin: 0px auto; border: 10px solid #c9d6e4; background-color: #ededed; padding: 10px; font-size: 12px; font-family: Tahoma; margin-top: 30px; color: #818181; text-align: left;">
<div style="font-size: 30px; font-family: impact; width: 788px; margin-bottom: 5px; height:60px">
	<font size="7"><font face="Impact" color="#008000">&nbsp;</font></font></div>
<font color="#000000" face="Impact" size="7"><center>[</font><font color="#000080" face="Impact" size="7">0m3ga</font><font color="#000000" face="Impact" size="7">] - </font>
<font color="#800000" face="Impact" size="7">BuildRP</font><font color="#000000" face="Impact" size="7"> Server</center></font>
<p>If you would like to be a Admin of this server, see below.</p>
<p> 1. Apply for it. (Maximum rank is Admin)</p>
<p>&nbsp;</p>
<p>Prices</p>
<ul>
  <li>VIP: $20</li>
  </ul>
<p>Note: Being a VIP does not give you the rights to bypass the rules. Every rule set up by 
0m3ga is to be followed. </p>
<p> Talk to an Admin about purchasing.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><font size="7"><strong><center>Modifications (Mods) &amp; Addons</center></strong></font></p>
<p>If you get any error signs while playing, it means that you don't have to models downloaded. It is recommended that you download the correct models from <a href="http://garrysmod.org">Garrysmod.org</a>.<b></p>
<p>This server uses the following mods:<ul>
  <font size="3"><li>Ulx</li></font>
  <font size="3"><li>Wiremod</li></font>
  <font size="3"><li>Key card (Wiremod addon)</li></font>
  <font size="3"><li>Phoenix Storms 3 (Phx3)</li></font>
  <font size="3"><li>Custom sTOOLS</li></font>
  <font size="3"><li>Custom sWEPS</li></font>
  <li><font size="3">Simple Prop Protection<br>
    <br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></li>
  <font size="7"><strong><center>====Rules / Terms====</center></strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b></li>
</ul>
<center>


<center>
  <em>By closing the MOTD, you agree to have read and understand the following rules</em>
</center>
;<br>
<br>
</font>
<p>
1. Leave other players stuff. Do not Proppush their creations.<br>
<br>
2. Don't  text/microphone spam.<br>
<br>
3. Obey New Life Rule.<br>
<br>
4. We expect you to be mature, no matter what age.<br>
<br>
5. Obey the admins. Don't disrespect them. If you need any assistance, contact Bob the Builder on steam.<br>
<br>
6. Doors must have a keypad on both sides. Not a single prop is allowed to block a path without keypads.<br>
<br>
7. Do you job right, don't screw around, or expect to be demoted.<br>
<br>
8. No prop surfing/killing/pushing.&nbsp; If it was an accident then that is ok.&nbsp; But do not repeat.<br>
<br>
9. Minge bags will be dealt with accordingly.<br>
<br>
10. RDM (Random DeathMatching) will result in warning,kick,temp ban,ban.
<br>
<br>
11. Don't ask for admin, and do not ask for limits highered, they are there for a reason.
<br>
<br>
12. No swearing and racism or anything of the sorts.</p>
<p>13. Don't propspam. This will result in a permanent ban.</p>
<p>14. Don't talk in caps, or else you might get muted.</p>
<p><br>
  <br>
  </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="7"><strong><center>
    <p>Laws  </p>
  </center>
  </strong></font><font color="#800000" size="3"> No weapons out in public.&nbsp; 
    A police officer has every right to arrest you for having a weapon out.&nbsp; It 
    is their discretion to either taze you, arrest you or use deadly force if 
    necessary.<br>
  </font></p>
<p><font color="#800000" size="3">You must purchase a permit to sell guns/shipments if you are a gun dealer.&nbsp; 
  You may get this from the Mayor or Police Chief</font><font color="#800000" size="3">.&nbsp; If 
    there is no one then just sell your goods until there is one. (If you sell without permit your items can be confiscated)<br>
  </font></p>
<p><font color="#800000" size="3"> No killing or stealing.&nbsp; If you are &quot;caught&quot; killing/stealing or a 
  witness saw you then you may get arrested and dealt with by the police.<br>
</font></p>
<p><font color="#800000" size="3">The Mayor may set more laws which are reasonable for 0m3ga's Build RP.</font></p>
<p><i>These rules and laws will be updated frequently!</i><br>
  <br>
  <br>
  
  <br>
</p>
<h2>
<p><center><font size="6" color="#000000">Jobs List - Costum jobs included!</font></center><br>
  <br>
  <font size="2">1.<font color="#FF9900"> /gundealer</font> - If there is a 
gundealer then a non-gundealer cannot buy guns for themselves.&nbsp; They must 
purchase from the gundealer. Also, the gundealer has new shipments he/she can buy.&nbsp; Please check out the 
&quot;F2&quot; menu to view the new ones.<br>

<br>
2. <font color="#FF0000">/votepresident </font>- Mayor must create laws for the 
city.&nbsp; Some basic laws that must be used are: 1. NO *weapons* out in public.&nbsp; If a person is seen with any type of weapon 
the mayor or a cop can taser/arrest. 2. NO killing/stealing.&nbsp; If a person is killing arrest immediately.&nbsp; 
Cops have authority to use deadly force. 3. Gun dealers must get a license from the mayor to sell weapons.<br>
<br>
3. <font color="#008000">/citizen</font> - This is the basic job and when you 
join the server is the default job.&nbsp; <br>

<br>
4. <font color="#000000">/mobboss </font>- This job is the boss of the 
gangsters.&nbsp; He has the option to set an &quot;agenda&quot; which the gangsters must 
follow.&nbsp; A mob boss is not allowed to random kill.<br>
<br>
5. <font color="#666666">/terrorist</font> - The terrorist's job is to take 
people hostage and also has the weapon &quot;jihad bomb.&quot;&nbsp; Even though you are 
allowed to have this 
you must use this minimally as to not cause a lot of killings. Also this job 
comes with an AK47 which is used for hostage takeovers.<br>

<br>
6. <font color="#0000FF">/votecp</font> - This is the cop job.&nbsp; A cop must 
follow the laws that the mayor has set forth.&nbsp; He/she cannot use deadly 
force unless needed. You must try to taser first then arrest rather than killing and using a gun.<br>
<br>
7. <font color="#000099">/voteswat</font> - This is the swat team.&nbsp; This 
job comes with an M4A1, flash and smoke grenades.&nbsp; This job is used to take 
out terrorists and rescue hostages.<br>

<br>
8. <font color="#0000FF">/votechief</font> - The chief is responsible for 
keeping the cops in line.&nbsp; They do the same job as the cops.<br>
<br>
9. <font color="#666666">/gangster</font> - The gangster job serves the mob 
boss.&nbsp; They follow the mob boss' agenda.&nbsp; This job comes with a knife 
and throwing knife.<br>

<br>
10. <font color="#006600">/hoe </font>- The slutty hoe comes with a weapon 
called the &quot;Drilldo.&quot;&nbsp; It is a drill that has a dilldo attached to it.&nbsp; 
So, be careful when you buy her &quot;service.&quot; :D<br>
<br>
11. <font color="#666633">/ninja</font> - The ninja comes with a sword and 
throwing stars.&nbsp; This job can be used to do many things.<br>

<br>
12. /zombie - The zombie job is a torment job.&nbsp; It has the zombie model and 
also a &quot;weapon&quot; that just makes zombie sounds.<br>
<br>
13. <font color="#000000">/hitman</font> - The hitman's job is to offer its 
&quot;services&quot; to players.&nbsp; He is allowed to kill minimally because of his job.<br>

<br>
14. <font color="#000080">/spy </font>- The spy has the ability to cloak and 
also has a lockpick/keypad cracker.&nbsp; Players should buy his services if 
they need access to certain areas ect.<br>
<br>
15. <font color="#800080">/isd</font> - Illegal Substance Dealer.&nbsp; This 
dealer is able to sell items keypad hacker and lockpick.&nbsp; We will be adding 
more things he can buy soon.&nbsp; Maybe Jihad bomb? :P Use the commands:
<span style="font-weight: 400"><i>/buy keypadhax</i></span>&nbsp; and
<span style="font-weight: 400"><i>&nbsp;/buy lockpick</i></span>.</font></p>
<p><font size="2">16. <font color="#0099FF">/guard</font> - A guard is here to protect a shop, guard the president, or something else like that. He's equiped with a Stunstick and a Standard Side-arm.<br>
  <br>
  17. <font color="#FF0000">/votevice</font> - Vice President.&nbsp; Assistant to 
  the President.&nbsp; He gets a USP.<br>
  <br>
  18. <font color="#0099FF">/voteswatsniper </font>- The S.W.A.T. Sniper.&nbsp; An 
  essential part of the S.W.AT. You must first be SWAT before you can be vote for 
  swat sniper.<br>
  <br>
  19.&nbsp; <font color="#000000">/drugdealer </font>- The drug dealer is able to 
  buy and sell vodka.&nbsp; Use the command <span style="font-weight: 400"><i>/buydrug 
    vodka</i></span> to spawn Vodka.<br>
  <br>
  20. <font color="#FF00FF">/medic</font> - The doctor.&nbsp; Go to him if you 
  need fixed up.<br>
  <br>
  21. <font color="#FF3300">/banker</font> - A player can become the banker and 
  own a bank.&nbsp; Don't get robbed!<br>
  <br>
  </font>
  <font size="4">***Admin Only Jobs***<br>
  </font>
  <font size="2">1. <font color="#FFCC00">/gamemaster</font> - The game master job 
  is currently only for Assistant Superadmins and Superadmins.&nbsp; The game 
  master job is responsible explicitly for administrating the server.&nbsp; The GM 
  will assist players out and help with disputes.<br>
  
  <br>
  <br>
					</p>
				</div>
			</div>

		</body>
	</html>
	]]

/*====================================================
======================================================
====================================================*/

	if not file.Exists( "ASSmod/motd.txt" ) then
		file.Write( "ASSmod/motd.txt", ASSMOTD_HTMLScript )
	end
	if file.Exists( "ASSmod/motd.txt" ) then
		resource.AddFile( "data/ASSmod/motd.txt" )
	end
	
	function PLUGIN.OpenMOTDWhenPlayerSpawns( ply )
		ply:ConCommand( "ASS_MotdOpen" )
	end
	hook.Add( "PlayerInitialSpawn", "OpenMOTDWhenPlayerSpawns", PLUGIN.OpenMOTDWhenPlayerSpawns )

	function PLUGIN.DeleteOldMOTDWhenDisCon( ply )
		umsg.Start( "DeleteMOTD", ply )
		umsg.End()
	end
	hook.Add( "PlayerDisconnected", "DeleteOldMOTDWhenDisCon", PLUGIN.DeleteOldMOTDWhenDisCon )

end

if (CLIENT) then

	function PLUGIN.OpenMOTD( ply, cmd, args )

		local MOTDFrame = vgui.Create( "DFrame" )
		MOTDFrame:SetTitle( "Message of The day" )
		MOTDFrame:SetSize( ScrW() - 100, ScrH() - 100 )
		MOTDFrame:Center()
		MOTDFrame:ShowCloseButton( false )
		MOTDFrame:SetBackgroundBlur( true )
		MOTDFrame:SetDraggable( false )
		MOTDFrame:SetVisible( true )
		MOTDFrame:MakePopup()

		local MOTDHTMLFrame = vgui.Create( "HTML", MOTDFrame )
		MOTDHTMLFrame:SetPos( 25, 50 )
		MOTDHTMLFrame:SetSize( MOTDFrame:GetWide() - 50, MOTDFrame:GetTall() - 150 )
		MOTDHTMLFrame:SetHTML( file.Read( "ASSmod/motd.txt" ) )

		local CloseButton = vgui.Create( "DButton", MOTDFrame )
		CloseButton:SetSize( 100, 50 )
		CloseButton:SetPos( ( MOTDFrame:GetWide() / 2.3 ) - ( CloseButton:GetWide() / 2 ), MOTDFrame:GetTall() - 60 )
		CloseButton:SetText( "Accept" )
		CloseButton:SetVisible( false )
		CloseButton.DoClick = function()
			MOTDFrame:Remove()
		end
			
		local OpenButton = vgui.Create( "DButton", MOTDFrame )
		OpenButton:SetSize( 100, 50 )
		OpenButton:SetPos( ( MOTDFrame:GetWide() / 1.7 ) - ( OpenButton:GetWide() / 2 ), MOTDFrame:GetTall() - 60 )
		OpenButton:SetText( "Decline" )
		OpenButton:SetVisible( true )
		OpenButton.DoClick = function()
			RunConsoleCommand( "disconnect" )
		end

		local x, y = MOTDFrame:GetPos()
		timer.Simple( ASSMOTD_TimeToWait, function()
			CloseButton:SetVisible( true )
			gui.SetMousePos( x + ( MOTDFrame:GetWide() / 2 ), y + 50 )
		end )

	end
	concommand.Add( "ASS_MotdOpen", PLUGIN.OpenMOTD )

	function PLUGIN.DeleteOldMOTDWhenLeave( ply )
		file.Delete( "ASSmod/motd.txt" )
	end
	hook.Add( "ShutDown", "DeleteOldMOTDWhenLeave", PLUGIN.DeleteOldMOTDWhenLeave )
	usermessage.Hook( "DeleteMOTD", PLUGIN.DeleteOldMOTDWhenLeave )

	function PLUGIN.ShowMOTD(MENUITEM)
		RunConsoleCommand( "ASS_MotdOpen" )
	end
	function PLUGIN.AddNonAdminMenu(MENU)
		MENU:AddOption( "View MOTD", PLUGIN.ShowMOTD )
	end

end

ASS_RegisterPlugin(PLUGIN)


