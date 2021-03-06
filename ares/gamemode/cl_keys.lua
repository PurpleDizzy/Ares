function GM:OnSpawnMenuOpen()
	RunConsoleCommand( "player_dropweapon" )
end

function DoWepSelect(gun)
	net.Start("weaponSelect")
		net.WriteString(gun)
	net.SendToServer()
end

function GM:PlayerBindPress(ply, bind, pressed)
	if not IsValid(ply) then return end

	if bind == "invprev" and pressed then
		if not ply:Alive() or ply:Team() == TEAM_SPECTATOR or not IsValid(ply:GetActiveWeapon()) then return end
		local curslot = ply:GetActiveWeapon().Slot
	  
		for i = curslot + 1, 8 do
			for k,v in pairs(ply:GetWeapons()) do
				if v.Slot == i then DoWepSelect(v:GetClass()) end
			end
		end
	  
		for i = 0, curslot - 1 do
			for k,v in pairs(ply:GetWeapons()) do
				if v.Slot == i then DoWepSelect(v:GetClass()) end
			end
		end
	  
		return true
	elseif bind == "invnext" and pressed then
		if not ply:Alive() or ply:Team() == TEAM_SPECTATOR or not IsValid(ply:GetActiveWeapon()) then return end
		
		local curslot = ply:GetActiveWeapon().Slot
	  
		for i =  curslot - 1,0,-1 do
			for k,v in pairs(ply:GetWeapons()) do
				if v.Slot == i then DoWepSelect(v:GetClass()) end
			end
		end
	  
		for i = 8,curslot + 1,-1 do
			for k,v in pairs(ply:GetWeapons()) do
				if v.Slot == i then DoWepSelect(v:GetClass()) end
			end
		end
   
		return true
	elseif string.sub(bind, 1, 4) == "slot" and pressed then
		if not ply:Alive() or ply:Team() == TEAM_SPECTATOR then return end
		local idx = tonumber(string.sub(bind, 5, -1)) or 1
		idx = idx - 1
		--choose gun in idx
		for k,v in pairs(ply:GetWeapons()) do
			if v.Slot == idx then
				DoWepSelect(v:GetClass())
			end
		end
		return true
	elseif (bind == "undo" or bind == "gmod_undo") and pressed then
		return true
	elseif bind == "+zoom" then

		return true
	elseif bind == "+speed" then
		if ply:KeyDown(IN_ATTACK2) then return true end -- Prevents player from ADS then Sprint
		
		return false
	elseif bind == "+attack2" then
		if ply:KeyDown(IN_SPEED) then return true end -- Prevents player from Sprinting then ADS
		
		return false
	elseif bind == "+jump" and pressed then
		if ply:OnGround() then ply:SetStamina(ply:Stamina() - 5) end
	
		return false
	end
end


--[[---------------------------------------------------------
   Name: gamemode:KeyPress( )
   Desc: Player pressed a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyPress( ply, key )

	if not IsFirstTimePredicted() then return end
	if not IsValid(ply) then return end

end


--[[---------------------------------------------------------
   Name: gamemode:KeyRelease( )
   Desc: Player released a key (see IN enums)
-----------------------------------------------------------]]
function GM:KeyRelease( ply, key )

	if not IsFirstTimePredicted() then return end
	if not IsValid(ply) then return end

end
