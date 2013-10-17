if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType			= "knife"
--SWEP.Type = "Rifle"

SWEP.PrintName			= "Knife"
SWEP.Slot				= 0

--SWEP.Icon = "VGUI/ttt/icon_m16"


SWEP.Base				= "ares_melee_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModelFlip = false

SWEP.Primary.Delay			= 1
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Damage = 15
SWEP.Primary.Cone = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1

SWEP.ViewModel			= "models/weapons/v_knife_t.mdl"
SWEP.WorldModel			= "models/weapons/w_knife_t.mdl"

SWEP.Primary.Sound = Sound( "Weapon_Knife.Slash" )

