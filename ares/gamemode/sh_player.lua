local plymeta = FindMetaTable( "Player" )
if not plymeta then return end

function plymeta:FireLasers(b)

	local rand = Vector(math.Rand( -b.Spread.x, b.Spread.x), math.Rand(-b.Spread.y, b.Spread.y), math.Rand(-b.Spread.z, b.Spread.z))

	local newdir = (b.Dir - rand)

	tr = {}
	tr.start = b.Src
	tr.endpos = b.Src + newdir * 99999	-- REALLY shitty way of doing this.
	tr.filter = self
	tr.mask = MASK_SHOT
	
	tr = util.TraceLine(tr)
	
	local eData = EffectData()
		eData:SetStart(tr.HitPos)
		eData:SetOrigin(tr.HitPos)
		eData:SetNormal(tr.Normal)
			
	
	// -- Effects for Laser
	if tr.MatType == MAT_METAL then
		util.Effect("Sparks", eData)
	elseif tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH then
		util.Effect("BloodImpact", eData)
		util.Decal("Blood", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	end
	
	
	if tr.HitWorld then
		util.Decal("FadingScorch", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal )
		util.Effect("Impact", eData)
	elseif not tr.MatType == MAT_GLASS then 
		util.Decal("FadingScorch", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal )
		util.Effect("Impact", eData)
	end
	
		
	if SERVER then
		
		local HitEnt = tr.Entity

		if not IsValid(HitEnt) then return end
		
		// -- Damages for Laser
		// -- Glass sometimes labled as Concrete for some reason
		if not (tr.MatType == MAT_GLASS or tr.MatType == MAT_CONCRETE) then
		
			local dmginfo = DamageInfo()
				dmginfo:SetDamage(b.Damage)
				dmginfo:SetAttacker(self)
				dmginfo:SetInflictor(self:GetActiveWeapon())
				dmginfo:SetDamageForce(Vector(b.Force, b.Force, 0))
				dmginfo:SetDamagePosition(b.Src)
				dmginfo:SetDamageType(DMG_ENERGYBEAM)

				HitEnt:DispatchTraceAttack(dmginfo, b.Src, b.Dir)
		end
		
		if tr.MatType == MAT_WOOD then HitEnt:Ignite(10,0) end
	
	end
	
	return b.Callback(self, tr, dmginfo)

end
	


function GM:CanPlayerEnterVehicle( player, vehicle, role )
	return false
end

if CLIENT then
	
end