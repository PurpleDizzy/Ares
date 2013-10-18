function HUDHide( hud )
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if hud == v then return false end
	end
end
hook.Add("HUDShouldDraw","HUDHide",HUDHide)

function AresHud()
	CheckTeam()
	RenderTextAndBars()
end	
hook.Add( "HUDPaint", "AresHud", AresHud )

function CheckTeam()
	local Team = LocalPlayer():Team()
	if Team == 1 then
		local Team = "Rebel"
		draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 210, 90, 0, 100) )
		surface.CreateFont("HPFont", {size = 35, weight = 700, antialias = true, shadow = false, font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos ( 70, ScrH() - 99)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
	if Team == 2 then
		local Team = "Imperial"
		draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 0, 90, 210, 100) )
		surface.CreateFont("HPFont", {size = 35, weight = 700, antialias = true, shadow = false, font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos ( 50, ScrH() - 99)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
	if Team == 1002 then
		local Team = "Spectator"
		draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 40, 40, 40, 100) )
		surface.CreateFont("HPFont", {size = 35, weight = 700, antialias = true, shadow = false, font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos ( 40, ScrH() - 99)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
end
hook.Add( "AresHud", "CheckTeam", CheckTeam )
function RenderTextAndBars()
	local ply = LocalPlayer()
	local HP = LocalPlayer():Health()
	local MHP = math.Clamp( HP, 0, 100 )
	draw.RoundedBox( 4, ScrW() - 100, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	draw.RoundedBox( 4, 10, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	if MHP ~= 0 then
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 220, 108, 108, 230) )
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 225, 255, 255, 40) )
	end
	surface.CreateFont("HPFont", {size = 20, weight = 700, antialias = true, shadow = false, font = "HUDNumber"})
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 175, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( MHP )
	surface.CreateFont("HPFont", {size = 20, weight = 700, antialias = true, shadow = false, font = "HUDNumber"})
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 20, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( "HP" )
end
hook.Add( "AresHud", "RenderTextAndBars", RenderTextAndBars )