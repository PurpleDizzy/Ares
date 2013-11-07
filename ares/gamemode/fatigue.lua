-- Messy.. --
local RPlayer = debug.getregistry().Player 
local REntity = debug.getregistry().Entity 

AddCSLuaFile("fatigue.lua")

if SERVER then 

util.AddNetworkString("Fatigue_Effecting") 

end 

function RPlayer:SetFatigueEffect( bool ) 

if SERVER then 

self.Fatigue_Effect = bool net.Start("Fatigue_Effecting") 
net.WriteBit(self.Fatigue_Effect) net.Send(self) 

end 

end 

function PlayerFatigueM( pl, move ) 
	local Max_Walk = pl:GetWalkSpeed() 
	local Max_Run = pl:GetRunSpeed() 
	local Speed = pl:GetVelocity():Length() 
	local Speed_F = move:GetForwardSpeed() 
	local Speed_S = move:GetSideSpeed() 
	local SPRINTING = pl:KeyDown(131072)
	local GROUND = pl:OnGround() 
	local CT = CurTime()
	
if not pl.Fatigue_M then 
	pl.Fatigue_M = 100 
end 
if not pl.Fatigue_R then 
	pl.Fatigue_R = CT 
end 
if not pl.Fatigue_Effect then 
	pl.Fatigue_Effect = false 
end 
if (Speed_F >= Max_Run or Speed_S >= Max_Run) and SPRINTING and GROUND then 
	pl.Fatigue_M = math.Clamp(pl.Fatigue_M - 0.2,0,100) 
	pl.Fatigue_R = CT + 1 
	if pl.Fatigue_M <= 0 and not pl.Fatigue_Effect then 
		pl:SetFatigueEffect(true) 
	end 
	elseif (Speed_F < Max_Run and Speed_S < Max_Run and pl.Fatigue_M < 100 and pl.Fatigue_R and CT >= pl.Fatigue_R and not SPRINTING and GROUND) then 
		pl.Fatigue_M = math.Clamp(pl.Fatigue_M + 0.3,0,100) 
		if pl.Fatigue_Effect then 
			pl:SetFatigueEffect(false) 
		end 
	end 
	if pl.Fatigue_Effect then 
		if Speed_F > Max_Walk*0.9 then 
			move:SetForwardSpeed( Max_Walk*0.9 )
			elseif Speed_F < Max_Walk*-0.9 then 
				move:SetForwardSpeed( Max_Walk*-0.9 ) 
			end 
			if Speed_S > Max_Walk*0.9 then 
				move:SetSideSpeed( Max_Walk*0.9 ) 
				elseif Speed_S < Max_Walk*-0.9 then
					move:SetSideSpeed( Max_Walk*-0.9 ) 
				end 
			end 
		end 
hook.Add("Move","PlayerFatigueMHook",PlayerFatigueM)
 
if CLIENT then 
 
function FatigueFF( msg ) 
	local PL = LocalPlayer() 
	local BL = net.ReadBit() == 1 PL.Fatigue_Effect = BL 
end 
net.Receive("Fatigue_Effecting",FatigueFF) 
 
function FatigueMVision() 
	local PL = LocalPlayer() 
	local Fatigue = PL.Fatigue_Effect 
	if not PL.FatigueVision then 
		PL.FatigueVision = 1 
	end 
	local Vis = PL.FatigueVision 
	if Fatigue and Vis > 0.3 then 
		PL.FatigueVision = math.Clamp(PL.FatigueVision - RealFrameTime()*1,0.3,1) 
	elseif not Fatigue and Vis < 1 then 
		PL.FatigueVision = math.Clamp(PL.FatigueVision + RealFrameTime()*1,0.3,1) 
	end 
	local Vis = PL.FatigueVision 
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
hook.Add("RenderScreenspaceEffects","FatigueMVisionHook",FatigueMVision) end