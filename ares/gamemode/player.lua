function GM:PlayerInitialSpawn( ply )

	ply:StripWeapons()

	if ( ply:Team() == TEAM_UNASSIGNED ) then
	
		ply:Spectate( OBS_MODE_FIXED )
		return
		
	end

	ply:SetTeam( TEAM_SPECTATOR )
	ply:Spectate( OBS_MODE_ROAMING )
	
	if ( GAMEMODE.TeamBased ) then
		ply:ConCommand( "gm_showteam" )
	end
	
	ply:SetModel( "models/player/breen.mdl" )

end

function GM:PlayerLoadout(ply)
	ply:Give("assault")
	ply:Give("knife")
	AmmoSpawn(ply)
	
	ply:SelectWeapon("assault")
end

// -- Give proper ammo to each spawning player
function AmmoSpawn(ply)
	local amt = 1
	for k,v in pairs(ply:GetWeapons()) do
		if v:GetType() == "primary" then
			amt = 4
		elseif v:GetType() == "secondary" then
			amt = 3
		end
		
		if v:GetAmmo() == "none" or v:GetAmmo() == nil then return end
		
		local ammoname, defclip = v:GetAmmo()
		
		ply:GiveAmmo( amt * defclip, ammoname)
		
	end
end


function GM:PlayerSpawn(ply)
	if  ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED  then

		GAMEMODE:PlayerSpawnAsSpectator( ply )
		return
	
	end

	-- Stop observer mode
	ply:UnSpectate()
	ply:SetWalkSpeed(230)
	ply:SetRunSpeed(300)
	
	ply:StripWeapons()
	ply:StripAmmo()
	self:PlayerLoadout(ply)
end

local function PlayerDropWeapon(ply)
	if ply:GetActiveWeapon():IsValid() then
		ply:GetActiveWeapon():DoDrop()
	end
end

local function DropAllWeapons(ply)
	for k,v in pairs(ply:GetWeapons()) do
		v:DoDrop()
		v:DampenDrop()
	end
end

hook.Add("DoPlayerDeath", "Player.DropAllWeapons", DropAllWeapons)

concommand.Add("player_dropweapon", PlayerDropWeapon)
//concommand.Add( "player_dropweapon_toggle", ToggleDropWeapon)

function GM:PlayerDeathSound()
	-- Return true to not play the default sounds
	return true
end

function GM:PlayerSwitchFlashlight( ply, SwitchOn )
	return true
end

function GM:GetFallDamage( ply, flFallSpeed )

	return flFallSpeed * .05; -- near the Source SDK value
	
end

function GM:PlayerCanPickupWeapon( ply, ent )
	local weptable = {}
	
	weptable = ply:GetWeapons()
	
	for k,v in pairs(weptable) do
		if v:GetSlot() == ent:GetSlot() then return false end
	end
	
	return true
end

util.AddNetworkString( "weaponSelect" )

net.Receive("weaponSelect", function(len, ply)
	ply:SelectWeapon(net.ReadString())
end)