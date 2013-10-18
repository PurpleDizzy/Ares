include( 'shared.lua' ) --Tell the client to load shared.lua
include( 'cl_keys.lua' )
include( 'cl_hud.lua' )
include( 'sh_player.lua' )

function HUDHide( areshud ) -- Might move to cl_hud.lua
	for k, v in pairs{"CHudHealth","CHudBattery"} do
		if areshud == v then return false end
	end
end
hook.Add("HUDShouldDraw","HUDHide",HUDHide)