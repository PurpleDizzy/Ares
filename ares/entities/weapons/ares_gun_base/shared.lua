-- Custom weapon base, used to derive from CS one, still very similar

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = false
   SWEP.CSMuzzleFlashes = true
end

SWEP.Base = "weapon_base"

SWEP.Category           = "Ares"
SWEP.Spawnable          = false
SWEP.AdminSpawnable     = false

//SWEP.IsSilent = false -- kills silently. Not used yet, maybe later?
SWEP.Type = "firearm"
SWEP.IsGrenade = false
SWEP.AllowDrop = true
SWEP.AllowSights = true
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

//SWEP.StoredAmmo = 0	-- Taken from ttt. Might not be used but just in case.
//SWEP.IsDropped = false  -- ^ Used to save ammo in gun when ply drops

SWEP.DeploySpeed = 1.4

SWEP.IronSightsPos 		= Vector( 0, 0, 0 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD



function SWEP:PrimaryAttack()

   if not self:CanPrimaryAttack() then return end
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   self.Weapon:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )

   self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
   self:TakePrimaryAmmo( 1 )

end

function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end

   if self.Weapon:Clip1() <= 0 then
      self:DryFire()
      return false
   end
   return true
end

function SWEP:DryFire()
   if CLIENT and LocalPlayer() == self.Owner then
	  if self.Type == "firearm" then
		if self.Slot == 2 then
			self:EmitSound( "Default.ClipEmpty_Rifle" )
		elseif self.Type == "secondary" then
			self:EmitSound( "Default.ClipEmpty_Pistol" )
		end
	  end
   end
   
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   
end

function SWEP:SecondaryAttack()

end

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

   self.Weapon:SendWeaponAnim(self.PrimaryAnim)

   self.Owner:MuzzleFlash()
   self.Owner:SetAnimation( PLAYER_ATTACK1 )

   if not IsFirstTimePredicted() then return end

   numbul = numbul or 1
   cone   = cone   or 0.01

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self.Owner:GetShootPos()
   bullet.Dir    = self.Owner:GetAimVector()
   bullet.Spread = Vector( cone, cone, 0 )
   bullet.Tracer = 4
   bullet.TracerName = self.Tracer or "Tracer"
   bullet.Force  = dmg
   bullet.Damage = dmg
   bullet.Callback	= function(attacker, tracedata, dmginfo) 
		
						return self:BulletPenetrate(0, attacker, tracedata, dmginfo) 
					  end

   self.Owner:FireBullets( bullet )

   -- Owner can die after firebullets
   if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

end

function SWEP:BulletPenetrate(bouncenum, attacker, tr, paininfo)
	
	local MaxPenetration

	if self.Primary.Ammo == "SniperPenetratedRound" then -- .50 Ammo 
		MaxPenetration = 20
	elseif self.Primary.Ammo == "pistol" then -- pistols
		MaxPenetration = 8
	elseif self.Primary.Ammo == "357" then -- revolvers with big ass bullets
		MaxPenetration = 12
	elseif self.Primary.Ammo == "smg1" then -- smgs
		MaxPenetration = 14
	elseif self.Primary.Ammo == "ar2" then -- assault rifles
		MaxPenetration = 16
	elseif self.Primary.Ammo == "buckshot" then -- shotguns
		MaxPenetration = 8
	elseif self.Primary.Ammo == "slam" then -- secondary shotguns
		MaxPenetration = 8
	elseif self.Primary.Ammo ==	"AirboatGun" then -- metal piercing shotgun pellet
		MaxPenetration = 20
	else
		MaxPenetration = 16
	end
	
	// -- Direction (and length) that we are going to penetrate
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
		
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + PenetrationDirection
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	// -- Bullet didn't penetrate.
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
	// -- Damage multiplier depending on surface
	local fDamageMulti = 0.5
	
	if self.Primary.Ammo == "SniperPenetratedBullet" then
		fDamageMulti = 1
	elseif(tr.MatType == MAT_CONCRETE or tr.MatType == MAT_METAL) then
		fDamageMulti = 0.3
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_GLASS) then
		fDamageMulti = 0.8
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 0.9
	end
	
	local newdamage = self.Primary.Damage * .6
		
	// -- Fire bullet from the exit point using the original trajectory
	local penetratedbullet = {}
		penetratedbullet.Num 		= 1
		penetratedbullet.Src 		= trace.HitPos
		penetratedbullet.Dir 		= tr.Normal	
		penetratedbullet.Spread 	= Vector(0, 0, 0)
		penetratedbullet.Tracer	= 1
		penetratedbullet.TracerName 	= "m9k_effect_mad_penetration_trace"
		penetratedbullet.Force		= 5
		penetratedbullet.Damage	= paininfo:GetDamage() * fDamageMulti
		penetratedbullet.Callback  	= function(a, b, c)	
		local impactnum
		if tr.MatType == MAT_GLASS then impactnum = 0 else impactnum = 1 end
		return self:BulletPenetrate(bouncenum + impactnum, a,b,c) end	
		
	timer.Simple(0, function() if attacker != nil then attacker:FireBullets(penetratedbullet) end end)

	return true
end

function SWEP:DoDrop(ply)
	if self.AllowDrop then
		self.Owner:DropWeapon(self)
	end
end

function SWEP:DampenDrop()
   -- For some reason gmod drops guns on death at a speed of 400 units, which
   -- catapults them away from the body. Here we want people to actually be able
   -- to find a given corpse's weapon, so we override the velocity here and call
   -- this when dropping guns on death.
   local phys = self:GetPhysicsObject()
   if IsValid(phys) then
      phys:SetVelocityInstantaneous(Vector(0,0,-75) + phys:GetVelocity() * 0.001)
      phys:AddAngleVelocity(phys:GetAngleVelocity() * -0.99)
   end
end

function SWEP:Ammo1()
   return IsValid(self.Owner) and self.Owner:GetAmmoCount(self.Primary.Ammo) or false
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   return self.HeadshotMultiplier
end


function SWEP:Initialize()
   if CLIENT and self.Weapon:Clip1() == -1 then
      self.Weapon:SetClip1(self.Primary.DefaultClip)
   end

   self:SetDeploySpeed(self.DeploySpeed)

   -- compat for gmod update
   if self.SetWeaponHoldType then
      self:SetWeaponHoldType(self.HoldType or "pistol")
   end
   
   if SERVER then
		util.AddNetworkString( "IronSights" )
   end
   
end

function SWEP:Holster()
	self.Weapon:SetNextPrimaryFire(self.DeploySpeed)
	self.Weapon:SetIronsights(false)
	return true
end

function SWEP:Deploy()
	self.Weapon:SetIronsights(false)
end

function SWEP:Reload()
	self.Weapon:SetNetworkedBool("Ironsights", false)
	self.Weapon:DefaultReload( ACT_VM_RELOAD )
end

function SWEP:Think()
	self:IronSight()
end

function SWEP:IronSight()
	if self.Owner:KeyDown(IN_ATTACK2) then
		if ( !self.IronSightsPos ) then return end
		self.Weapon:SetNetworkedBool("Ironsights", true)
	else
		if ( !self.IronSightsPos ) then return end
		self.Weapon:SetNetworkedBool("Ironsights", false)
	end
end

function SWEP:SetIronsights(b)
	self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:GetIronsights()
	return self.Weapon:GetNWBool("Ironsights")
end



local IRONSIGHT_TIME = 0.25

function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end
	if self.Type == "melee" then return pos, ang end

	local bIron = self:GetIronsights()

	
	if bIron != self.bLastIron then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

