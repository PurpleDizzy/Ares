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
	local TV = LocalPlayer():Team()
	local TC = team.GetColor (TV)
	local T = team.GetName (TV)
	if TV ~= 1002 then	
		draw.RoundedBox( 4, 10, ScrH() - 100, 200, 40, TC )
		draw.DrawText(T, "TeamFont", 110, ScrH() - 99, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
		DrawHPBar()
		DrawWEPBar()
		DrawSprintBar()
	else
		draw.RoundedBox( 4, 10, ScrH() - 50, 200, 40, TC )
		draw.DrawText(T, "TeamFont", 110, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	end
end	
hook.Add( "HUDPaint", "AresHud", AresHud )
function DrawHPBar()
	local HPnum = LocalPlayer():Health()
	local HP = math.Clamp( HPnum, 0, 100 )
	if HPnum < 0 then HPnum = 0 end
	draw.RoundedBox( 4, 10, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
	if HP ~= 0 then
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 30, Color( 220, 108, 108, 230) )
		draw.RoundedBox( 4, 10, ScrH() - 50, math.Clamp( HP, 0, 200 )*2, 30, Color( 225, 255, 255, 40) )
	end
	draw.DrawText( HPnum , "HPFont", 180, ScrH() - 45, Color( 0, 0, 0, 255),TEXT_ALIGN_RIGHT)
	draw.DrawText( "HP" , "HPFont", 25, ScrH() - 45, Color( 0, 0, 0, 255),TEXT_ALIGN_LEFT)
end

function DrawSprintBar()	// -- DEBUG SPRINT BAR
	local Sprint = LocalPlayer():Stamina()
	if Sprint != 0 then
		draw.RoundedBox( 4, 10, ScrH() -20, math.Clamp( Sprint, 0, 200) * 2, 10, Color( 74, 150, 61, 210) )
	end
end


function DrawWEPBar()
	local WEPN = LocalPlayer():GetActiveWeapon().PrintName
	local SHOWAMMO = false
	if WEPN == nil then return end
	if IsValid(LocalPlayer():GetActiveWeapon()) then SHOWAMMO = LocalPlayer():GetActiveWeapon().DrawAmmo end
	if SHOWAMMO then
		local WEP = LocalPlayer():GetActiveWeapon()
		local CLIP = LocalPlayer():GetActiveWeapon():Clip1()
		local AMMO = LocalPlayer():GetAmmoCount(WEP:GetPrimaryAmmoType())
		local MAXC = LocalPlayer():GetActiveWeapon():GetTable().Primary.ClipSize
		draw.RoundedBox( 4, ScrW() - 215, ScrH() - 100, 200, 40, Color( 100,100,100,100) )
		draw.DrawText(WEPN, "WepFont", ScrW() - 115, ScrH() - 99, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
		draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 40, 40 ,40, 50) )
		if CLIP ~= 0 then
			draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, 30 )*6.7, 40, Color(100,100,100,255) )
			draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, math.Clamp( CLIP, 0, 30 )*6.7, 40, Color( 225, 255, 255, 40) )
		end
		draw.DrawText( CLIP , "AmmoCFont", ScrW() - 150, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
		draw.DrawText( "/" , "AmmoCFont", ScrW() - 115, ScrH() - 52, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
		draw.DrawText( AMMO , "AmmoCFont", ScrW() - 80, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	else
		draw.RoundedBox( 4, ScrW() - 215, ScrH() - 50, 200, 40, Color( 100,100,100,100) )
		draw.DrawText(WEPN, "WepFont", ScrW() - 115, ScrH() - 50, Color( 0, 0, 0, 255),TEXT_ALIGN_CENTER)
	end
end