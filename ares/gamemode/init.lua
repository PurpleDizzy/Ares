--------------------------------------------------------------
--------------------------------------------------------------
--------------------[[LUA FILES]]-----------------------------
--------------------------------------------------------------
--------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" ) --Tell the server that the client needs to download cl_init.lua
AddCSLuaFile( "shared.lua" ) --Tell the server that the client needs to download shared.lua

AddCSLuaFile( "sh_player.lua" ) --Tell the server that the client needs to download sh_player.lua

AddCSLuaFile( "cl_fatigue.lua" ) -- Tell the server that the client needs to download cl_fatigue.lua
AddCSLuaFile( "cl_hud.lua" )	--Tell the server that the client needs to download cl_hud.lua
AddCSLuaFile( "cl_keys.lua" )
AddCSLuaFile( "cl_scoreboard.lua" )	--Tell the server that the client needs to download cl_hud.lua
AddCSLuaFile( "cl_settingmenu.lua" )	--Tell the server that the client needs to download cl_hud.lua
 
include( 'shared.lua' ) --Tell the server to load shared.lua
include( 'player.lua' )	--Tell the server to load player.lua
include( 'sh_player.lua' )	--Tell the server to load sh_player.lua


--------------------------------------------------------------
--------------------------------------------------------------
--------------------[[FUNCTIONS]]-----------------------------
--------------------------------------------------------------
--------------------------------------------------------------

function GM:ShowHelp( ply ) -- This hook is called everytime F1 is pressed.
    umsg.Start( "SMenu", ply ) -- Sending a message to the client.
    umsg.End()
end --Ends function


