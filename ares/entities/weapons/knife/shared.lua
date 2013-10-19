if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName			= "Knife"
SWEP.Slot				= 0 -- One less than Displayed Slot Number

--SWEP.Icon = "your path"
SWEP.HoldType			= "knife"
SWEP.Type = "melee"

SWEP.Primary.Damage = 60


SWEP.ViewModelFlip = true
SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Knife.Slash" )


SWEP.Base				= "ares_gun_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.Ammo = "none"

SWEP.Primary.Delay			= 0.12
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = true
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1