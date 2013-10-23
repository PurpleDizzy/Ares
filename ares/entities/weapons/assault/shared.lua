if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName			= "M4A1"
SWEP.Slot				= 2 	-- One less than Displayed Slot Number
SWEP.HoldType			= "ar2"
SWEP.Type = "firearm"

SWEP.Primary.Delay		= 0.12
SWEP.Primary.Recoil		= 1.6
SWEP.Primary.Automatic 	= true
SWEP.Primary.Ammo 		= "pistol"
SWEP.Primary.Damage 	= 15
SWEP.Primary.Cone		= 0.018
SWEP.Primary.ClipSize 	= 30
SWEP.Primary.DefaultClip= 30
SWEP.Primary.MaxAmmo	= 60

SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 70
SWEP.ViewModel			= "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Primary.Sound 		= Sound( "Weapon_M4A1.Single" )

SWEP.IronSightsPos 		= Vector( 6, -1, 0.95 )
SWEP.IronSightsAng 		= Vector( 2.6, 1.37, 3.5 )



SWEP.Base				= "ares_gun_base"
SWEP.Spawnable			= true
SWEP.AdminSpawnable 	= true