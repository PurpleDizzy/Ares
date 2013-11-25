function onSprintThink(ply, move)	-- Sprint Function, run every tick, ONLY ON CLIENT

	if not IsValid(ply) then return end
	if not ply:Alive() then return end
	if ply:Team() == TEAM_SPECTATOR then return end
	
	if ply:Sprinting() then	-- Gets if the ply is Sprinting
		if move:GetForwardSpeed() == 0 and move:GetSideSpeed() == 0 then return end
		if ply:Stamina() >= 0 then
			ply:SetStamina(math.Clamp(ply:Stamina() - .1, 0, 100))
		end
		if ply:Stamina() <= 0 then
			net.Start("DoSprint")
				net.WriteBit(false)	-- Variables on both Client and Server create HUGE lag
			net.SendToServer()			-- so it's gotta be handled all client until very end.
		end
	else
		
		if ply:Stamina() <= 100 and (not ply:Sprinting()) then
			timer.Simple(0, function() ply:SetStamina(math.Clamp(ply:Stamina() + .08, 0, 100)) end)
		end
		if ply:Stamina() > 0 then
			net.Start("DoSprint")
				net.WriteBit(true)
			net.SendToServer()
		end
	end

end


hook.Add("Move", "SprintThink", onSprintThink) -- Every tick the Sprint Function is run CLIENTSIDE ONLY


function StaminaMVision() 
	local ply = LocalPlayer() 
	if not ply.StaminaVision then 
		ply.StaminaVision = 1 
	end 
	
	local Vis = ply.StaminaVision 
	if ply:Stamina() <= 16 and Vis > 0.3 then 
		ply.StaminaVision = math.Clamp(ply.StaminaVision - RealFrameTime()*1,0.3,1) 
	elseif ply:Stamina() > 0 and Vis < 1 then 
		ply.StaminaVision = math.Clamp(ply.StaminaVision + RealFrameTime()*1,0.3,1) 
	end 
	local Vis = ply.StaminaVision 
	local COLT = {} 
	COLT[ "$pp_colour_addr" ] = 0 
	COLT[ "$pp_colour_addg" ] = 0 
	COLT[ "$pp_colour_addb" ] = 0 
	COLT[ "$pp_colour_brightness" ] = 0 
	COLT[ "$pp_colour_contrast" ] = 1 
	COLT[ "$pp_colour_colour" ] = Vis 
	COLT[ "$pp_colour_mulr" ] = 0 
	COLT[ "$pp_colour_mulg" ] = 0 
	COLT[ "$pp_colour_mulb" ] = 0 
 
	if Vis < 1 then DrawColorModify( COLT ) 
	end 
end 

hook.Add("RenderScreenspaceEffects","StaminaMVisionHook",StaminaMVision)