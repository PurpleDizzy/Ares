function EFFECT:Init(data)
	lazmat = Material("effects/laser1")
	lazstart = data:GetOrigin()
	lazfinish = data:GetStart()
	lazcol = data:GetMagnitude()
	lazalpha = 255
	lazwidth = 32
end

function EFFECT:Think()
	lazalpha = lazalpha - 1000 * FrameTime()
	lazwidth = lazwidth - 50 * FrameTime()
	if lazalpha <= 0 then
		return false
	else
		return true
	end	
end

function EFFECT:Render()
	render.SetMaterial(lazmat)
	render.DrawBeam(lazstart, lazfinish, lazwidth, 0, 0.2, Color(255, lazcol, 0, lazalpha))
end