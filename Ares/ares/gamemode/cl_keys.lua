function GM:OnSpawnMenuOpen()
	RunConsoleCommand( "player_dropweapon" )
end

function GM:PlayerBindPress(ply, bind, pressed)
   if not IsValid(ply) then return end

   if bind == "invnext" and pressed then
   
      return true
   elseif bind == "invprev" and pressed then

      return true
   elseif string.sub(bind, 1, 4) == "slot" and pressed then
      local idx = tonumber(string.sub(bind, 5, -1)) or 1
	  --choose gun in idx
      return true
   end
end

-- Note that for some reason KeyPress and KeyRelease are called multiple times
-- for the same key event in multiplayer.
function GM:KeyPress(ply, key)
   if not IsFirstTimePredicted() then return end
   if not IsValid(ply) or ply != LocalPlayer() then return end
end

function GM:KeyRelease(ply, key)
   if not IsFirstTimePredicted() then return end
   if not IsValid(ply) or ply != LocalPlayer() then return end
end