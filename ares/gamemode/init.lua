--------------------------------------------------------------
--------------------------------------------------------------
--------------------[[LUA FILES]]-----------------------------
--------------------------------------------------------------
--------------------------------------------------------------

AddCSLuaFile( "cl_init.lua" ) --Tell the server that the client needs to download cl_init.lua
AddCSLuaFile( "shared.lua" ) --Tell the server that the client needs to download shared.lua

AddCSLuaFile( "cl_keys.lua" ) --Tell the server that the client needs to download cl_keys.lua
AddCSLuaFile( "sh_player.lua" ) --Tell the server that the client needs to download player_shd.lua
 
include( 'shared.lua' ) --Tell the server to load shared.lua
include( 'player.lua' )
include( 'sh_player.lua' )


--------------------------------------------------------------
--------------------------------------------------------------
--------------------[[FUNCTIONS]]-----------------------------
--------------------------------------------------------------
--------------------------------------------------------------



