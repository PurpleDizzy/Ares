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

SWEP.Base = "weapon_ares_basefirearm"

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

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	
	self:ShootLaser(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
//	self:TakePrimaryAmmo(self.Primary.NumShots)

end

function SWEP:ShootLaser( dmg, recoil, numbul, cone )

   if not IsFirstTimePredicted() then return end

   numbul = numbul or 1
   cone   = cone   or 0.01
   
   cone = self:CalculateCone(cone)
   
   local laser = {}
   laser.Num    = numbul
   laser.Src    = self.Owner:GetShootPos()
   laser.Dir    = self.Owner:GetAimVector()
   laser.Spread = Vector( cone, cone, 0 )
   laser.Tracer = 1
   laser.TracerName = "effects_ares_laserbeam"
   laser.Force  = dmg
   laser.Damage = dmg
   laser.Callback	= function(attacker, tracedata, dmginfo) 
		
						//if self.AllowPen then return self:LaserPenetrate(attacker, tracedata, dmginfo) end
					  end

   self.Owner:FireLasers( laser )
   
   -- Owner can die after firelasers
   if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end
   
   self.Owner:ViewPunch(Angle(-self.Primary.Recoil, 0, 0))
   
	local eyeang = self.Owner:EyeAngles()
	eyeang.pitch = eyeang.pitch - recoil
	self.Owner:SetEyeAngles( eyeang )

end


function SWEP:LaserPenetrate(attacker, tr, paininfo)
	
	local MaxPenetration = 20 // -- amount of objects it can go through
	
	// -- Direction (and length) that we are going to penetrate
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
	
	// -- Damage multiplier -- Changes per Surface and Type of SWEP
	local fDamageMulti = 0.5
	
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + PenetrationDirection
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	// -- Laser didn't penetrate
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
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
	
	// -- Fire bullet from the exit point using the original trajectory
	local penetratedlaser = {}
		penetratedlaser.Num 		= 1
		penetratedlaser.Src 		= trace.HitPos
		penetratedlaser.Dir 		= tr.Normal	
		penetratedlaser.Spread 	= Vector(0, 0, 0)
		penetratedlaser.Tracer	= 1
		penetratedlaser.TracerName = "effects_ares_laserbeam"
		penetratedlaser.Force		= 5
		penetratedlaser.Damage	= self.Primary.Damage * fDamageMulti
		penetratedlaser.Callback  	= function(a, b, c)	

			return self:LaserPenetrate(a,b,c) end	
		
			timer.Simple(0, function() 
					if attacker != nil then 
						attacker:FireLasers(penetratedlaser) 
					end
		end)
	
	return true	
end
