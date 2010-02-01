local function NewInit ( )
	if GAMEMODE.Name != "GMod Open RPG" then
		if SERVER then
			AddCSLuaFile("autorun/draw.lua");
		else
			local Text = {};
			Text[1] = "0m3ga - Bringing the best out of you";
			Text[3] = "http://www.0m3ga.net/";
			
			local TimePer = 10;
			local Fade = 60;
				
			local Font = "default";
				
			local TextColor = Color(255, 255, 255, 255);
			local Background = Color(255, 255, 255, 150);
			local Foreground = Color(0, 0, 0, 175);
			
			local Start_Y = 0;
			local FadeAlpha = 255 / 60;
			local CurText = 1;
			local LastDo = 1;
			local CurFade = 60;
			local CurStart = 0;
			local Phase = false;
			
			function PulsarEffectDraw ( )
			
				Text[2] = GetGlobalString("ServerName", 'Loading data...');
			
				surface.SetFont(Font);
				X, Y = 0, 0
				for k, v in pairs(Text) do
					local X2, Y2 = surface.GetTextSize(v);
					
					if X2 > X then
						X = X2;
					end
					
					if Y2 > Y then
						Y = Y2;
					end
				end
				
				local Width = X + 10;
				local Height = Y + 10;
				local Start_X = (ScrW() * .5) - (Width * .5);
				local LineY = Start_Y + (Height * .5) - 1;
			
				draw.RoundedBox(2, Start_X - 1, Start_Y - 1, Width + 2, Height + 2, Background);
				draw.RoundedBox(2, Start_X, Start_Y, Width, Height, Foreground);
				
				if !Text[2] or Text[2] == "" then
					Text[2] = GetGlobalString("ServerName");
				end
				
				local PerformText = CurText;
				local Alpha = 255;
				
				if CurTime() > CurStart + TimePer then
					CurText = CurText + 1;
					
					if CurText > #Text then
						CurText = 1;
					end
					
					CurStart = CurTime() + 5000;
				end
				
				if LastDo != CurText then
					if !Phase then
						CurFade = CurFade - 1;
						PerformText = LastDo;
						Alpha = CurFade * FadeAlpha
										
						if CurFade == 0 then
							Phase = true;
						end
					else
						CurFade = CurFade + 1;
						PerformText = CurText;
						Alpha = CurFade * FadeAlpha
										
						if CurFade == Fade then
							Phase = false;
							LastDo = CurText;
						end
						
						CurStart = CurTime();
					end
				end
				
				draw.SimpleText(Text[PerformText], Font, ScrW() * .5, Start_Y + (Height * .5), Color(TextColor.r, TextColor.g, TextColor.b, Alpha), 1, 1);
				
				surface.SetDrawColor(Background.r, Background.g, Background.b, Background.a);
				surface.DrawLine(0, LineY, Start_X - 1, LineY);
				surface.DrawLine(Start_X + Width + 1, LineY, ScrW(), LineY);
			end
			
			hook.Add("HUDPaint", "PulsarEffectDraw", PulsarEffectDraw);
		end
	end
end
hook.Add('Initialize', 'NewInit', NewInit);