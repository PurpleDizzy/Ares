if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	resource.AddFile("sound/laser/laser1.wav")
	resource.AddFile("sound/laser/zoom.wav")
	resource.AddFile("sound/laser/zoomout.wav")
	resource.AddFile("sound/laser/reload.wav")
	resource.AddFile("sound/laser/dep.wav")
	resource.AddFile("sound/laser/holster.wav")
	resource.AddFile("sound/laser/out.wav")
	
end

if ( CLIENT ) then

	SWEP.PrintName		= "Laser"			
	SWEP.Author		= "Shs"
	SWEP.Slot		= 2
	SWEP.Description	= "Laser Rifle"
	SWEP.Purpose		= "None, really."
	SWEP.Instructions	= "\nPrimary Fire: PEW PEW\n\nUse+Primary/Secondary: Adjust Setting\n\nSecondary Fire: Toggle InfoVision(tm)"
	
end

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_iRifle.mdl"
SWEP.WorldModel			= "models/weapons/w_iRifle.mdl"

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType			= "ar2"

SWEP.Primary.Recoil		= 0.1
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 0
SWEP.Primary.Cone		= 0
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay		= 0.3
SWEP.Primary.DefaultClip	= 600
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "ar2"

SWEP.Secondary.Delay		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Base = "weapon_ares_baseenergy"

/*---------------------------------------------------------
   Primary Attack
---------------------------------------------------------*/


function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

				self:TakePrimaryAmmo(self.Weapon:GetNetworkedInt("firemode"))

				local gunown = self.Owner
				if self.Owner.SENT then
					local gunown = self.Owner.SENT.Entity
				end
				
				local Right = 3.65
				local Forward = 18
				local Up = -3.2
				
				local MuzzlePos = gunown:GetShootPos() + (gunown:GetRight() * Right) + (gunown:GetUp() * Up) + (gunown:GetForward() * Forward)
				local tr = gunown:GetEyeTrace()
				local norm = tr.Normal
				local newpos = tr.HitPos
				
				local Hitent = tr.Entity
				
			    local eData = EffectData()
				eData:SetStart(self.Owner:GetShootPos())
				eData:SetOrigin(tr.HitPos)
				eData:SetNormal(tr.Normal)

				if Hitent or tr.HitWorld then
					if SERVER then
						Hitent:TakeDamage(self.Primary.Damage)
					else
						if Hitent:IsPlayer() or Hitent == "prop_ragdoll" or Hitent:IsNPC() then
							util.Effect("BloodImpact",eData)
						else
							util.Decal("FadingScorch", newpos + norm, newpos - norm )
							util.Effect("Impact", eData)
						end
					end
				end

				if tr.MatType == MAT_METAL then
					util.Effect("Sparks", eData)
				end
				
				util.BlastDamage(self.Weapon, self.Owner, tr.HitPos, 25, self.Primary.Damage)

				local laz2 = {}
				local laz2 = EffectData()
				laz2:SetOrigin(MuzzlePos)
				laz2:SetStart(newpos)
				laz2:SetMagnitude(1)
				util.Effect("laser_rifle_beam", laz2)
				
				self:BulletPenetrate(0, self.Owner, tr, dmginfo)


end