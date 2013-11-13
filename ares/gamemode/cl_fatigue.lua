if CLIENT then
function onSprintThink(ply, move)	-- Sprint Function, run every tick, ONLY ON CLIENT

	if not IsValid(ply) then return end
	if not ply:Alive() then return end
	
	if ply:Sprinting() and ply:KeyDown(IN_ATTACK2) then
		net.Start("RunSpeed")
			net.WriteString("230")
		net.SendToServer()
	elseif ply:Sprinting() then	-- Gets if the ply is Sprinting
		if ply:Fatigue() >= 0 then
			ply:SetFatigue(math.Clamp(ply:Fatigue() - .1, 0, 100))
		end
		if ply:Fatigue() <= 10 then
			net.Start("RunSpeed")
				net.WriteString("230")	-- Variables on both Client and Server create HUGE lag
			net.SendToServer()			-- so it's gotta be handled all client until very end.
		end
	else
		if ply:Fatigue() <= 100 and ply:OnGround() then
			timer.Simple(1, function() ply:SetFatigue(math.Clamp(ply:Fatigue() + .08, 0, 100)) end)
		end
		if ply:Fatigue() > 0 then
			net.Start("RunSpeed")
				net.WriteString("300")
			net.SendToServer()
		end
	end

end


hook.Add("Move", "SprintThink", onSprintThink) -- Every tick the Sprint Function is run CLIENTSIDE ONLY

end

function FatigueMVision() 
	local ply = LocalPlayer() 
	if not ply.FatigueVision then 
		ply.FatigueVision = 1 
	end 
	
	local Vis = ply.FatigueVision 
	if ply:Fatigue() <= 16 and Vis > 0.3 then 
		ply.FatigueVision = math.Clamp(ply.FatigueVision - RealFrameTime()*1,0.3,1) 
	elseif ply:Fatigue() > 0 and Vis < 1 then 
		ply.FatigueVision = math.Clamp(ply.FatigueVision + RealFrameTime()*1,0.3,1) 
	end 
	local Vis = ply.FatigueVision 
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

hook.Add("RenderScreenspaceEffects","FatigueMVisionHook",FatigueMVision)