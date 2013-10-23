if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName			= "Knife"
SWEP.Slot				= 0 -- One less than Displayed Slot Number
SWEP.HoldType			= "knife"
SWEP.Type = "melee"

SWEP.Primary.Damage		= 60

SWEP.ViewModelFlip 		= false
SWEP.ViewModelFOV 		= 80
SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Knife.Slash" )


SWEP.Base				= "ares_melee_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1