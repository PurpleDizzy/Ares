local plymeta = FindMetaTable( "Player" )  -- Grabs the Player metatable for doing classes :D

function plymeta:FireLasers(b)

	local Right = 6
	local Forward = 18
	local Up = -3.2

	// -- Calculate the Spread/Cone
	local rand = Vector(math.Rand( -b.Spread.x, b.Spread.x), math.Rand(-b.Spread.y, b.Spread.y), math.Rand(-b.Spread.z, b.Spread.z))

	local newdir = (b.Dir + rand)

	// -- Create the trace for the laser. KA-POW
	trace = {}
	trace.start = b.Src
	trace.endpos = b.Src + newdir * 99999	-- REALLY shitty way of doing this.		StartPoint + (New Direction * Distance)
	trace.filter = self 	-- Else you'll shoot yourself each trigger pull
	trace.mask = nil -- So the first trace doesn't go through windows
	
	tr = util.TraceLine(trace)
	
	local MuzzlePos = self:GetShootPos() + (self:GetRight() * Right) + (self:GetUp() * Up) + (self:GetForward() * Forward)	-- Correct the origin of Laser Shot

	
	// -- General Effect Data for multiple use
	local eData = EffectData()
		eData:SetStart(tr.StartPos)
		eData:SetOrigin(tr.HitPos)
		eData:SetScale(1)
		eData:SetNormal(tr.Normal)
		
	// -- THEM LASER BEAMS
	if b.TracerName != nil then
		util.Effect(b.TracerName, eData)
	end
	
	local hitsomething = true
	
	//while hitsomething == true do
	
	// -- Effects for laser-hit NOT WORKING on ENTITIES.
	if tr.MatType == MAT_METAL or tr.MatType == MAT_GRATE then
		util.Effect("HelicopterImpact", eData)
		util.Decal("Impact.Metal", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	elseif tr.MatType == MAT_FLESH then
		util.Effect("BloodImpact", eData)
		util.Decal("BloodyFlesh", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	elseif tr.MatType == MAT_ALIENFLESH then
		util.Effect("BloodImpact", eData)
		util.Decal("AlienFlesh", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	elseif tr.MatType == MAT_DIRT or tr.MatType == MAT_SAND then
		util.Effect("Impact", eData)
		util.Decal("Impact.Sand", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	elseif tr.MatType == MAT_CONCRETE then
		util.Effect("Impact", eData)
		util.Decal("Impact.Concrete", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
	elseif MAT_WOOD then
		util.Effect("Impact", eData)
		util.Decal("Impact.Wood", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal)
//	else
//		util.Effect("Impact", eData)
//		util.Decal("FadingScorch", tr.HitPos + tr.Normal, tr.HitPos - tr.Normal )
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
		
		if tr.MatType == MAT_WOOD then HitEnt:Ignite(10,0) end -- Lights wood on fire
	
	end
	
	local blahtrace = {}
	blahtrace.start = tr.HitPos
	blahtrace.endpos = tr.HitPos + tr.Normal * 99999
	blahtrace.filter = self
	
	tr = util.TraceLine(blahtrace)
	
	if not tr.Hit then
		hitsomething = false
	end
	
	
	//return b.Callback(self, tr, dmginfo)
//end
end

function plymeta:GetMaxFatigue()
	return 100
end

function plymeta:SetFatigue(amt)
	self.FatigueVal = amt --FatigueVal takes on the new amount
end

function plymeta:Fatigue()
	if self.FatigueVal == nil then self.FatigueVal = self:GetMaxFatigue() end
	return self.FatigueVal	-- Return the Fatigue Amount
end

function plymeta:Sprinting()
	if not self:Alive() then return end
	
	if self:KeyDown(IN_SPEED) and self:OnGround() then
		return true
	end
	
	return false
end




function GM:CanPlayerEnterVehicle( player, vehicle, role )
	return false
end