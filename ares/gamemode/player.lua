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

end

function GM:PlayerLoadout(ply)
	ply:Give("assault")
	ply:GiveAmmo(999,"pistol")
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
	
	self:PlayerLoadout(ply)
end

local ShouldDropWeapon = true

local function ToggleDropWeapon(ply)
	if ShouldDropWeapon then
		ply:PrintMessage(HUD_PRINTNOTIFY,"Weapon drop disabled")
		ShouldDropWeapon = false
	else
		ply:PrintMessage(HUD_PRINTNOTIFY, "Weapon drop enabled!")
		ShouldDropWeapon = true
	end
end

local function PlayerDropWeapon(ply)
	if ShouldDropWeapon and ply:GetActiveWeapon():IsValid() then
		ply:DropWeapon(ply:GetActiveWeapon())
	end
end

hook.Add("DoPlayerDeath", "Player.DropWeapon", PlayerDropWeapon)

concommand.Add("player_dropweapon", PlayerDropWeapon)
concommand.Add( "player_dropweapon_toggle", ToggleDropWeapon)

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