ares_WalkSpeed = 230
ares_RunSpeed = 300

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
	ply:Give("weapon_ares_debugassault")
	ply:Give("weapon_ares_debuglaserpistol")
	ply:Give("weapon_ares_debugknife")
	AmmoSpawn(ply)
	
	ply:SelectWeapon("weapon_assault_debug")
end

// -- Give proper ammo to each spawning player
function AmmoSpawn(ply)
	local amt = 1
	for k,v in pairs(ply:GetWeapons()) do
		if v.Slot == 2 then
			amt = 4
		elseif v.Slot == 1 then
			amt = 3
		end
		
		if v.Primary.Ammo == "none" or v.Primary.Ammo == nil then return end
		
		ply:GiveAmmo( amt * v.Primary.DefaultClip, v.Primary.Ammo)
		
	end
end


function GM:PlayerSpawn(ply)
	if  ply:Team() == TEAM_SPECTATOR or ply:Team() == TEAM_UNASSIGNED  then

		GAMEMODE:PlayerSpawnAsSpectator( ply )
		return
	
	end

	-- Stop observer mode
	ply:UnSpectate()
	ply:SetWalkSpeed(ares_WalkSpeed)
	ply:SetRunSpeed(ares_RunSpeed)
	
	ply:StripWeapons()
	ply:StripAmmo()
	self:PlayerLoadout(ply)
	ply:AllowImmediateDecalPainting(true)
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

concommand.Add("cleanmap", function() game.CleanUpMap() end)

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
		if v.Slot == ent.Slot then return false end
	end
	
	return true
end

util.AddNetworkString( "weaponSelect" )

net.Receive("weaponSelect", function(len, ply)
	ply:SelectWeapon(net.ReadString())
end)

util.AddNetworkString("DoSprint")

net.Receive("DoSprint", function(len, ply)
	if net.ReadBit() == true then
		ply:SetRunSpeed(230) -- Doesn't seem to make a difference for whatever reason
	else
		ply:SetRunSpeed(300)
	end
end)
