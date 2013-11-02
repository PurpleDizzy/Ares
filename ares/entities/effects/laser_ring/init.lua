

EFFECT.Mat = Material( "effects/select_ring" )

/*---------------------------------------------------------
   Initializes the effect. The data is a table of data 
   which was passed from the server.
---------------------------------------------------------*/
function EFFECT:Init( data )
	
	local size = math.random(2,8)
	self.Entity:SetCollisionBounds( Vector( -size,-size,-size ), Vector( size,size,size ) )
	
	local Pos = data:GetOrigin() + data:GetNormal() * 2
		
	self.Entity:SetPos( Pos )
	self.Entity:SetAngles( data:GetEntity():GetAngles() )
	
	self.Pos = data:GetOrigin()
	self.Normal = data:GetNormal()
	self.Col = data:GetMagnitude()
	
	self.Size = size
	self.Alpha = 200
	
end


/*---------------------------------------------------------
   THINK
---------------------------------------------------------*/
function EFFECT:Think( )
if (self.Alpha < 1 ) then
return false
end

self.Alpha = self.Alpha - 8
self.Size = self.Size + 0.2
return true
end

/*---------------------------------------------------------
   Draw the effect
---------------------------------------------------------*/
function EFFECT:Render( )

if (self.Alpha < 1 ) then return end

local ringmat = math.random(1,2)

render.SetMaterial(self.Mat)
	
render.DrawQuadEasy(self.Entity:GetPos(), self.Entity:GetAngles():Forward(), self.Size, self.Size, Color( 255, self.Col, 0, self.Alpha ))						 
end
