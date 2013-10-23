if SERVER then
   AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName			= "Laser Pistol"
SWEP.Slot				= 1 -- One less than Displayed Slot Number

--SWEP.Icon = "your path
SWEP.HoldType			= "pistol"
SWEP.Type = "energy"

SWEP.Primary.Delay			= 0.12
SWEP.Primary.Recoil			= 1.6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Damage = 15
SWEP.Primary.Cone = 3
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.ClipMax = 60

SWEP.ViewModelFlip = true
SWEP.ViewModelFOV = 75
SWEP.ViewModel  = "models/weapons/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

SWEP.Primary.Sound = Sound( "weapons/physcannon/superphys_launch4.wav" )
SWEP.IronSightsPos = Vector(4.5, 0, 3.4)
SWEP.IronSightsAng = Vector(0, 0, 0)


SWEP.Base				= "ares_energy_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
