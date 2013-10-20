-- Hide HL2 Hud --
function HUDHide( hud )
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if hud == v then return false end
	end
end
hook.Add("HUDShouldDraw","HUDHide",HUDHide)

local colortable = {
		rebel = 	team.GetColor (1),
		imperial = 	team.GetColor (2),
		spec = 	team.GetColor (1002)
};



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
surface.CreateFont("ver", {font = "HUDNumber",
                                    size = 10,
                                    weight = 500})
surface.CreateFont("ver2", {font = "HUDNumber",
                                    size = 20,
                                    weight = 1000})
-- Main --
function AresHud()
	Check()
	ver()
end	
hook.Add( "HUDPaint", "AresHud", AresHud )

function ver()
	draw.DrawText( "CODENAME: Ares" , "ver", 110, ScrH() - 10, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	draw.DrawText( "InDev" , "ver2", 30, 10, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end
function Check()
	local Team = LocalPlayer():Team()
	if Team == 1 then
		DrawHPBarAndText()
		RebelHUD()
		DrawWEPBarAndText()
	end
	if Team == 2 then
		DrawHPBarAndText()
		ImperialHUD()
		DrawWEPBarAndText()
	end
	if Team == 1002 then
		SpecHUD()
	end
end	
function RebelHUD()
	local Team = "Rebel"
	draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, colortable.rebel )
	draw.DrawText(Team, "TeamFont", 110, ScrH() - 99, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end
function ImperialHUD()
	local Team = "Imperial"
	draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, colortable.imperial )
	draw.DrawText(Team, "TeamFont", 110, ScrH() - 99, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end
function SpecHUD()
	local Team = "Spectator"
	draw.RoundedBox( 4, 10, ScrH() - 50, 200, 40, colortable.spec )
	draw.DrawText(Team, "TeamFont", 110, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
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
	draw.DrawText( MHP , "HPFont", 180, ScrH() - 40, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	draw.DrawText( "HP" , "HPFont", 25, ScrH() - 40, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end

function DrawWEPBarAndText()
	local ply = LocalPlayer()
	local WEPN = LocalPlayer():GetActiveWeapon().PrintName
	local TYPE = LocalPlayer():GetActiveWeapon().Type
//	local SLOT = LocalPlayer():GetActiveWeapon().Slot
if TYPE == "melee" then
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 100,100,100,100) )
	draw.DrawText(WEPN, "WepFont", ScrW() - 115, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end
if TYPE == "firearm" then
	local WEP = LocalPlayer():GetActiveWeapon()
	local CLIP = LocalPlayer():GetActiveWeapon():Clip1()
	local AMMO = LocalPlayer():GetAmmoCount(WEP:GetPrimaryAmmoType())
	local MAXC = LocalPlayer():GetActiveWeapon():GetTable().Primary.ClipSize
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 100, 200, 40, Color( 100,100,100,100) )
	draw.DrawText(WEPN, "WepFont", ScrW() - 115, ScrH() - 99, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	if WEPN == "M4A1" then
		if CLIP ~= 0 then
			draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color(100,100,100,255) )
			draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, MAXC )*6.7, 40, Color( 225, 255, 255, 40) )
		end
	end
	draw.DrawText( CLIP , "AmmoCFont", ScrW() - 150, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	draw.DrawText( "/" , "AmmoCFont", ScrW() - 115, ScrH() - 52, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	draw.DrawText( AMMO , "AmmoCFont", ScrW() - 80, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
end
end