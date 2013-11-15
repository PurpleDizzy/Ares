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
		
	local ImpactData = EffectData()
		ImpactData:SetOrigin(tr.HitPos)
		ImpactData:SetNormal(tr.HitPos)
		ImpactData:SetScale(20)
		
	// -- THEM LASER BEAMS
	if b.TracerName != nil then
		util.Effect(b.TracerName, eData)
	end
	
	local hitsomething = true
	
	//while hitsomething == true do
	
	// -- Effects for laser-hit NOT WORKING on ENTITIES.

	print(tr.SurfaceProps)
	
	if tr.SurfaceProps == 21 or tr.SurfaceProps == 17 or tr.SurfaceProps == 18 then
		util.Effect("Impact", ImpactData)
		util.Decal("Impact.Wood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	elseif tr.SurfaceProps == 3 or tr.SurfaceProps == 2 or tr.SurfaceProps == 66 or tr.SurfaceProps == 8 or tr.SurfaceProps == 7 then
		util.Effect("Sparks", ImpactData)
		util.Decal("Impact.Metal", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	elseif tr.SurfaceProps == 63 then
		util.Effect("Impact", ImpactData)
		util.Decal("Impact.Glass", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	elseif tr.SurfaceProps != 28 then
		util.Effect("Impact", eData)
		util.Decal("Impact.Concrete", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
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
	if self:Team() == TEAM_SPECTATOR then return end
	if not self:Alive() then return end
	
	if self:KeyDown(IN_SPEED) and (not self:KeyDown(IN_JUMP)) and (not self:KeyDown(IN_ATTACK2)) then
		return true
	end
	
	return false
end




function GM:CanPlayerEnterVehicle( player, vehicle, role )
	return false
end