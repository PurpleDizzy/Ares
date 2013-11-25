local plymeta = FindMetaTable( "Player" )  -- Grabs the Player metatable for doing classes :D

function plymeta:FireLasers(b) -- Function that fires the lasers. Who knew?

					
	if not IsFirstTimePredicted() then return end

	local Right = 6 	-- Used for getting
	local Forward = 18	-- laser start
	local Up = -3.2		-- point
	
	if b.Num < 1 then b.Num = 1 end
	
	for c = 1, b.Num, 1 do

		// -- Calculate the Spread/Cone
		local rand = Vector(math.Rand( -b.Spread.x, b.Spread.x), math.Rand(-b.Spread.y, b.Spread.y), math.Rand(-b.Spread.z, b.Spread.z))
		local newdir = (b.Dir + rand)


		// -- Create the trace for the laser. KA-POW
		trace = {}
		trace.start = b.Src
		trace.endpos = b.Src + newdir * 99999	-- StartPoint + (New Direction * Distance)
		trace.filter = self 	-- Else you'll shoot yourself each trigger pull

		tr = util.TraceLine(trace)

		//local MuzzlePos = self:GetShootPos() + (self:GetRight() * Right) + (self:GetUp() * Up) + (self:GetForward() * Forward)	-- Correct the origin of Laser Shot


		// -- CEffectData for Laser Impact
		local ImpactData = EffectData()
			ImpactData:SetOrigin(tr.HitPos)
			ImpactData:SetScale(0.5)
			ImpactData:SetRadius(tr.SurfaceProps) -- Send the Material as "Radius"
				
		// -- CEffectData for Laser
		local eData = EffectData()
			eData:SetStart(self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_R_Hand")))
			eData:SetOrigin(tr.HitPos)
			eData:SetNormal(tr.Normal)
					
		// -- Effects for laser-hit
		if tr.SurfaceProps != 28 and tr.SurfaceProps != 0 then -- Hit all world objects except glass
			util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal) -- do the scorch decal
			util.Effect("Impact", ImpactData)	-- Handle impacts on NODRAW objects
		end

		if tr.MatType == MAT_FLESH then -- Asshole entities don't do decals properly. So check if its fleshy
			util.Effect("BloodImpact", ImpactData)	-- if so, do a blood effect
			self:FireBullets({Num=1, Src=b.Src, Dir=b.Dir, Spread=Vector(0,0,0), Tracer=0, Force=1, Damage=0})	-- and do a dud bullet to create the proper decal
		end
		
		util.Effect("effects_ares_laserbeam", eData)
		util.Effect("ares_fx_laser_impact", ImpactData) -- And now the fx for laser impacts like smoke and debris
			

		local HitEnt = tr.Entity
		if not IsValid(HitEnt) then return end
			
		local dmginfo = DamageInfo()
			dmginfo:SetDamage(b.Damage)
			dmginfo:SetAttacker(self)
			dmginfo:SetInflictor(self:GetActiveWeapon())
			dmginfo:SetDamageForce(Vector(b.Force, b.Force, 0))
			dmginfo:SetDamagePosition(b.Src)
			dmginfo:SetDamageType(DMG_ENERGYBEAM)
			
	// -- Damages for Laser, Ignores Glass.
	// -- Glass sometimes labled as Concrete for some reason
	if not (tr.SurfaceProps == 0 or tr.SurfaceProps == 28) then
		HitEnt:DispatchTraceAttack(dmginfo, tr.StartPos, tr.Normal)
	else
		dmginfo:SetDamage(b.Damage * 1.5)	-- if the trace DOES hit glass, DMG is mult by 1.5
	end
	
	
	// -- Wood props get lit on fire
	if (tr.SurfaceProps == 17 or tr.SurfaceProps == 18 or tr.SurfaceProps == 21) and SERVER then HitEnt:Ignite(10,0) end -- Light wood props on fire

	if b.Callback then return b.Callback(self, tr, dmginfo) end -- Callback function. In most cases, the Laser Pen.
	
	end
	
end

function plymeta:GetMaxStamina()
	return 100
end

function plymeta:SetStamina(amt)
	self.StaminaVal = amt --StaminaVal takes on the new amount
end

function plymeta:Stamina()
	if self.StaminaVal == nil then self.StaminaVal = self:GetMaxStamina() end
	return self.StaminaVal	-- Return the Stamina Amount
end

function plymeta:Sprinting()
	if self:Team() == TEAM_SPECTATOR then return end 	-- if ply isn't alive
	if not self:Alive() then return end   			  	--	then he doesn't need to sprint
	
	// -- If shifting on the ground, not jumping or aiming, then he's sprinting.
	if self:KeyDown(IN_SPEED) and self:OnGround() and (not (self:KeyDown(IN_JUMP) or self:KeyDown(IN_ATTACK2))) then
		return true
	end
	
	return false
end




function GM:CanPlayerEnterVehicle( player, vehicle, role )
	return false
end