if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType			= "ar2"
--SWEP.Type = "Rifle"

SWEP.PrintName			= "M4A1"
SWEP.Slot				= 2

--SWEP.Icon = "VGUI/ttt/icon_m16"


SWEP.Base				= "ares_gun_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

--SWEP.ViewModelFlip = true

SWEP.Primary.Delay			= 0.12
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Damage = 15
SWEP.Primary.Cone = 0.018
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.ClipMax = 60

SWEP.ViewModel			= "models/weapons/v_rif_m4a1.mdl"
SWEP.ViewModelFlip = true
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Primary.Sound = Sound( "Weapon_M4A1.Single" )

SWEP.IronSightsPos 		= Vector( 6, 1, 0.95 )
SWEP.IronSightsAng 		= Vector( 2.6, 1.37, 3.5 )


