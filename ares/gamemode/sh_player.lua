local plymeta = FindMetaTable( "Player" )  -- Grabs the Player metatable for doing classes :D

function plymeta:FireLasers(b) -- Function that fires the lasers. Who knew?

	local Right = 6 	-- Used for getting
	local Forward = 18	-- laser start
	local Up = -3.2		-- point

	// -- Calculate the Spread/Cone
	local rand = Vector(math.Rand( -b.Spread.x, b.Spread.x), math.Rand(-b.Spread.y, b.Spread.y), math.Rand(-b.Spread.z, b.Spread.z))
	local newdir = (b.Dir + rand)

	// -- Create the trace for the laser. KA-POW
	trace = {}
	trace.start = b.Src
	trace.endpos = b.Src + newdir * 99999	-- REALLY shitty way of doing this.		StartPoint + (New Direction * Distance)
	trace.filter = self 	-- Else you'll shoot yourself each trigger pull
	trace.mask = MASK_SHOT -- So the first trace doesn't go through windows
	
	tr = util.TraceLine(trace)
	
	//local MuzzlePos = self:GetShootPos() + (self:GetRight() * Right) + (self:GetUp() * Up) + (self:GetForward() * Forward)	-- Correct the origin of Laser Shot

	
	// -- CEffectData for Laser Impact
	local ImpactData = EffectData()
				ImpactData:SetOrigin(tr.HitPos)
				ImpactData:SetScale(0.4)
				ImpactData:SetRadius(tr.SurfaceProps) -- Send the Material as "Radius"

	
	// -- Effects for laser-hit
	if tr.SurfaceProps == 39 then
		util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	elseif tr.SurfaceProps != 28 then
		util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end

	util.Effect("ares_fx_laser_impact", ImpactData)
	
	
	if SERVER then
		
		local HitEnt = tr.Entity

		if not IsValid(HitEnt) then return end
		
		// -- Damages for Laser, Ignores Glass.
		// -- Glass sometimes labled as Concrete for some reason
		if not (tr.SurfaceProps == 0 or tr.SurfaceProps == 28) then
		
			local dmginfo = DamageInfo()
				dmginfo:SetDamage(b.Damage)
				dmginfo:SetAttacker(self)
				dmginfo:SetInflictor(self:GetActiveWeapon())
				dmginfo:SetDamageForce(Vector(b.Force, b.Force, 0))
				dmginfo:SetDamagePosition(b.Src)
				dmginfo:SetDamageType(DMG_ENERGYBEAM)

				HitEnt:DispatchTraceAttack(dmginfo, b.Src, b.Dir)
		end
		
		if tr.SurfaceProps == 17 or tr.SurfaceProps == 18 or tr.SurfaceProps == 21 then HitEnt:Ignite(10,0) end -- Light wood props on fire
	
	end
	
	//return b.Callback(self, tr, dmginfo) -- Callback function. In most cases, the Laser Pen.

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
	
	if self:KeyDown(IN_SPEED) and self:OnGround() and (not (self:KeyDown(IN_JUMP) or self:KeyDown(IN_ATTACK2))) then
		return true
	end
	
	return false
end




function GM:CanPlayerEnterVehicle( player, vehicle, role )
	return false
end