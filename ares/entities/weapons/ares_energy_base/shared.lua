-- Custom weapon base, used to derive from CS one, still very similar

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.DrawAmmo		= true
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = false
   SWEP.CSMuzzleFlashes = false
end

SWEP.Base = "ares_gun_base"

SWEP.Category           = "Ares"
SWEP.Spawnable          = false
SWEP.AdminSpawnable     = false


SWEP.Type = "energy"
SWEP.AllowDrop = true
SWEP.AllowSights = true
SWEP.AllowPen = true
SWEP.Slot = 2


SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false


SWEP.Primary.Sound          = Sound( "" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 1
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15

SWEP.Primary.ClipSize       = 10
SWEP.Primary.DefaultClip    = 10
SWEP.Primary.ClipMax        = SWEP.Primary.ClipSize * 4

SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"


SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.ClipMax      = -1

SWEP.HeadshotMultiplier = 2.7 -- haven't modified

SWEP.DeploySpeed = 1.4

SWEP.IronSightsPos 		= Vector( 0, 0, 0 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )



function SWEP:PrimaryAttack()

	if not self:CanPrimaryAttack() then return end
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	self.Weapon:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	
	self:ShootLaser(self.Owner, self.Primary.Damage, self.Owner:GetEyeTrace(), self.Primary.Cone, self.Primary.NumShots)
	self:TakePrimaryAmmo(self.Primary.NumShots)

end

function SWEP:ShootLaser(attacker, damage, tr, spread, num)

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	
	local HitEnt = tr.Entity
	
	local eData = EffectData()
		eData:SetStart(tr.HitPos)
		eData:SetOrigin(tr.HitPos)
		eData:SetNormal(tr.Normal)
		
	// -- Damages for Laser
	// -- Glass sometimes labled as Concrete for some reason
	if not (tr.MatType == MAT_GLASS or tr.MatType == MAT_CONCRETE) then
	
		local dmg = DamageInfo()
			dmg:SetDamage(damage)
			dmg:SetAttacker(attacker)
			dmg:SetInflictor(self.Weapon)
			dmg:SetDamageForce(tr.Normal * 1500)
			dmg:SetDamagePosition(tr.StartPos)
			dmg:SetDamageType(DMG_ENERGYBEAM)

			HitEnt:DispatchTraceAttack(dmg, tr.StartPos + (tr.Normal * 3), HitEnt:GetPos())
	end
	
	if tr.MatType == MAT_WOOD and SERVER then HitEnt:Ignite(10,0) end
	
	// -- Effects for Laser
	if tr.MatType == MAT_METAL then
		util.Effect("Sparks", eData)
	elseif tr.MatType == MAT_GLASS then
		// -- No Effects for Glass
	elseif tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH then
		util.Effect("BloodImpact", eData)
		util.Decal("Blood", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	else
		util.Decal("FadingScorch", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal )
		util.Effect("Impact", eData)
	end

	
	local LaserEffect = EffectData()
	//LaserEffect:SetOrigin(attacker:GetShootPos())
	LaserEffect:SetStart(attacker:GetShootPos())
	LaserEffect:SetMagnitude(1)
	util.Effect("laser_rifle_beam", LaserEffect)
	
	//self:LaserPenetrate(attacker, tr, dmg)
	

end

function SWEP:LaserPenetrate(attacker, tr, paininfo)
	
	local MaxPenetration = 20 // -- amount of objects in can go through
	
	// -- Direction (and length) that we are going to penetrate
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
	
	// -- Damage multiplier -- Changes per Surface and Type of SWEP
	local fDamageMulti = 0.5
	
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + 1
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	
	if tr.MatType == MAT_CONCRETE then
		fDamageMulti = .3
	elseif tr.MatType == MAT_METAL then
		fDamageMulti = 0.6
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC) then
		fDamageMulti = 1
	elseif tr.MatType == MAT_GLASS then
		fDamageMulti = 1.5
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 1
	end
	
	timer.Simple(0, self.Weapon:ShootLaser(attacker, self.Primary.Damage * fDamageMulti, trace, 0, 1))
	
	return true
			
end
