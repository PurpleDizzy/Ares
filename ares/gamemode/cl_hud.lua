function AresHud()
	local ply = LocalPlayer()
	local HP = LocalPlayer():Health()
	local Team = LocalPlayer():Team()
	
	if Team == 1 then
			local Team = "Rebel"
		draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 100, 200, 40, Color( 210, 90, 0, 100) )
		surface.CreateFont("HPFont", {
		size = 20,
		weight = 700,
		antialias = true,
		shadow = false,
		font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos (ScrW() - 1260, ScrH() - 90)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
	
	if Team == 2 then
			local Team = "Imperial"
		draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 100, 200, 40, Color( 0, 90, 210, 100) )
		surface.CreateFont("HPFont", {
		size = 20,
		weight = 700,
		antialias = true,
		shadow = false,
		font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos (ScrW() - 1260, ScrH() - 90)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
		if Team == 1002 then
			local Team = "Spectator"
		draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 100, 200, 40, Color( 40, 40, 40, 100) )
		surface.CreateFont("HPFont", {
		size = 20,
		weight = 700,
		antialias = true,
		shadow = false,
		font = "HUDNumber"})
		surface.SetTextColor( 0, 0, 0, 255)
		surface.SetTextPos (ScrW() - 1260, ScrH() - 90)
		surface.SetFont( "HPFont" )
		surface.DrawText( Team )
	end
	
	draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 220, 108, 108, 230) )
	draw.RoundedBox( 4, ScrW() - 1270, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 225, 255, 255, 40) )
	surface.CreateFont("HPFont", {
	size = 20,
	weight = 700,
	antialias = true,
	shadow = false,
	font = "HUDNumber"})
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos (ScrW() - 1100, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( HP )
		surface.CreateFont("HPFont", {
	size = 20,
	weight = 700,
	antialias = true,
	shadow = false,
	font = "HUDNumber"})
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos (ScrW() - 1260, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( "HP" )
end
hook.Add( "HUDPaint", "AresHud", AresHud )