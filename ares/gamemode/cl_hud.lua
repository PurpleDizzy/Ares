-- Hide HL2 Hud --
function HUDHide( hud )
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if hud == v then return false end
	end
end
hook.Add("HUDShouldDraw","HUDHide",HUDHide)
-- FONTS --
surface.CreateFont("HPFont", {font = "HUDNumber",
                                    size = 20,
                                    weight = 700})
									
surface.CreateFont("TeamFont", {font = "HUDNumber",
                                    size = 35,
                                    weight = 700})

surface.CreateFont("AmmoCFont", {font = "HUDNumber",
                                    size = 40,
                                    weight = 700})
									
surface.CreateFont("WepFont", {font = "HUDNumber",
                                    size = 35,
                                    weight = 700})
-- Main --
function AresHud()
	DrawHPBarAndText()
	CheckTeam()
end	
hook.Add( "HUDPaint", "AresHud", AresHud )

function CheckTeam()
	local Team = LocalPlayer():Team()
	if Team == 1 then
		RebelHUD()
		DrawWEPBarAndText()
	end
	if Team == 2 then
		ImperialHUD()
		DrawWEPBarAndText()
	end
	if Team == 1002 then
		SpecHUD()
	end
end	
function RebelHUD()
	local Team = "Rebel"
	draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 210, 90, 0, 100) )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 70, ScrH() - 99)
	surface.SetFont( "TeamFont" )
	surface.DrawText( Team )
end
function ImperialHUD()
	local Team = "Imperial"
	draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 0, 90, 210, 100) )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 50, ScrH() - 99)
	surface.SetFont( "TeamFont" )
	surface.DrawText( Team )
end
function SpecHUD()
	local Team = "Spectator"
	draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, Color( 40, 40, 40, 100) )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 40, ScrH() - 99)
	surface.SetFont( "TeamFont" )
	surface.DrawText( Team )
end
function DrawHPBarAndText()
	local ply = LocalPlayer()
	local HP = LocalPlayer():Health()
	local MHP = math.Clamp( HP, 0, 100 )
	draw.RoundedBox( 4, 10, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	if MHP ~= 0 then
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 220, 108, 108, 230) )
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 40, Color( 225, 255, 255, 40) )
	end
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 175, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( MHP )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( 20, ScrH() - 40)
	surface.SetFont( "HPFont" )
	surface.DrawText( "HP" )
end

function DrawWEPBarAndText()
	local ply = LocalPlayer()
	local WEP = LocalPlayer():GetActiveWeapon()
	local WEPN = LocalPlayer():GetActiveWeapon().PrintName
	local TYPE = LocalPlayer():GetActiveWeapon().Type
//	local MAXC = LocalPlayer():GetActiveWeapon():GetTable().Primary.ClipSize
if TYPE == "melee" then
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 100, 200, 40, Color( 100,100,100,100) )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 155, ScrH() - 99)
	surface.SetFont( "WepFont" )
	surface.DrawText( WEPN )
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	//if CLIP ~= 0 then
	//	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color(100,100,100,255) )
	//	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color( 225, 255, 255, 40) )
	//end
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 150, ScrH() - 50)
	surface.SetFont( "AmmoCFont" )
	surface.DrawText( "Melee" )
end
if TYPE == "primary" then
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 100, 200, 40, Color( 100,100,100,100) )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 155, ScrH() - 99)
	surface.SetFont( "WepFont" )
	surface.DrawText( WEPN )
	local CLIP = LocalPlayer():GetActiveWeapon():Clip1()
	local AMMO = LocalPlayer():GetAmmoCount(WEP:GetPrimaryAmmoType())
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	//if CLIP ~= 0 then
	//	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color(100,100,100,255) )
	//	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color( 225, 255, 255, 40) )
	//end
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 150, ScrH() - 50)
	surface.SetFont( "AmmoCFont" )
	surface.DrawText( CLIP )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 100, ScrH() - 50)
	surface.SetFont( "AmmoCFont" )
	surface.DrawText( "/" )
	surface.SetTextColor( 0, 0, 0, 255)
	surface.SetTextPos ( ScrW() - 80, ScrH() - 50)
	surface.SetFont( "AmmoCFont" )
	surface.DrawText( AMMO )
end
end