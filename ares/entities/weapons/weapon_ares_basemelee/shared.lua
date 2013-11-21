-- Custom weapon base, used to derive from CS one, still very similar

if SERVER then
   AddCSLuaFile( "shared.lua" )
end

if CLIENT then
   SWEP.DrawCrosshair   = false
   SWEP.DrawAmmo   		= false
   SWEP.ViewModelFOV    = 82
   SWEP.ViewModelFlip   = false
   SWEP.CSMuzzleFlashes = true
end

SWEP.Base = "weapon_ares_basefirearm"

SWEP.Category           = "Ares"
SWEP.Spawnable          = false
SWEP.AdminSpawnable     = false


SWEP.Type = "melee"
SWEP.AllowDrop = false
SWEP.AllowSights = false

SWEP.Slot = 0


SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false


SWEP.Primary.Sound          = Sound( "" )
SWEP.Primary.Recoil         = 1.5
SWEP.Primary.Damage         = 60
SWEP.Primary.NumShots       = 1
SWEP.Primary.Cone           = 0.02
SWEP.Primary.Delay          = 0.15

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Primary.ClipMax        = -1

SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.ClipMax      = -1

SWEP.HeadshotMultiplier = 2.7

SWEP.DeploySpeed = 1.4

SWEP.IronSightsPos 		= Vector( 0, 0, 0 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD


function SWEP:SecondaryAttack()

end


function SWEP:CanPrimaryAttack()
   if not IsValid(self.Owner) then return end
   
   return true
end

function SWEP:Initialize()

   self:SetDeploySpeed(self.DeploySpeed)

   -- compat for gmod update
   if self.SetWeaponHoldType then
      self:SetWeaponHoldType(self.HoldType or "knife")
   end
   
end

function SWEP:PrimaryAttack()
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not IsValid(self.Owner) then return end

   if self.Owner.LagCompensation then -- for some reason not always true
      self.Owner:LagCompensation(true)
   end

   local spos = self.Owner:GetShootPos()
   local sdest = spos + (self.Owner:GetAimVector() * 70)

   local tr_main = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})
   local hitEnt = tr_main.Entity
   
        self.Weapon:EmitSound(self.Primary.Sound)
        
   if IsValid(hitEnt) or tr_main.HitWorld then
      self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )

      if not (CLIENT and (not IsFirstTimePredicted())) then
         local edata = EffectData()
         edata:SetStart(spos)
         edata:SetOrigin(tr_main.HitPos)
         edata:SetNormal(tr_main.Normal)

         edata:SetEntity(hitEnt)

         if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
            util.Effect("BloodImpact", edata)

            self.Owner:LagCompensation(false)
            self.Owner:FireBullets({Num=1, Src=spos, Dir=self.Owner:GetAimVector(), Spread=Vector(0,0,0), Tracer=0, Force=1, Damage=0})
         end
      end
   else
      self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
   end


   if SERVER then
      local tr_main = nil
      tr_main = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner})
      
      self.Owner:SetAnimation( PLAYER_ATTACK1 )

      if hitEnt and hitEnt:IsValid() then

         local dmg = DamageInfo()
         dmg:SetDamage(self.Primary.Damage)
         dmg:SetAttacker(self.Owner)
         dmg:SetInflictor(self.Weapon)
         dmg:SetDamageForce(self.Owner:GetAimVector() * 1500)
         dmg:SetDamagePosition(self.Owner:GetPos())
         dmg:SetDamageType(DMG_CLUB)

         hitEnt:DispatchTraceAttack(dmg, spos + (self.Owner:GetAimVector() * 3), sdest)
      end
   end

   if self.Owner.LagCompensation then
      self.Owner:LagCompensation(false)
   end
end
